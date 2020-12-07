try:
    from tkinter import *
    from tkinter.ttk import * 
except:
    from Tkinter import *
    from ttk import *


from Discover import *
import SensorBTLE as sensor
import csv
import datetime
import six
from ntplib import NTPClient, NTPException
from datetime import *

class Application:

    def __init__(self, master=None):
        self.window = Frame(master)
        self.window.pack()
        Label(self.window, text = '').pack()
        self.butScan = Button(self.window, text="Buscar", width = 15)
        self.butScan.pack()
        self.butScan.bind("<Button-1>", self.ScanDevices)

    def ConnectDevice(self, event):

        mac = self.names[self.menu.get()]
        self.polar = sensor.HRMonitor(mac)
        self.butConnect.destroy()
        self.butScan.destroy()
        self.menu.pack_forget()
        self.msg1.pack_forget()

        self.DisplayHR = Label(self.window, text="")
        self.DisplayHR.pack()

        self.butDisconnect = Button(self.window, text="Desconectar", width = 15)
        self.butDisconnect.pack()
        self.butDisconnect.bind("<Button-1>", self.DisconnectDevice)
        Label(self.window, text = '').pack()
        self.ShowHRMonitor()

    def DisconnectDevice(self, event):
        self.window.destroy()

        self.window = Frame()
        self.window.pack()

        Label(self.window, text = '').pack()
        self.butScan = Button(self.window, text="Buscar", width = 15)
        self.butScan.pack()
        self.butScan.bind("<Button-1>", self.ScanDevices)

        self.polar.finish()
        self.DisplayHR.destroy()

    def ShowHRMonitor(self):

        if self.DisplayHR.winfo_exists() == 1:
            hr = self.polar.readHR()
            self.DisplayHR.configure(text="%s - %s" % (hr[1], hr[2]))
            with open('data.csv', 'a') as csvfile:
                filewriter = csv.writer(csvfile, delimiter=',', escapechar = ' ', quoting=csv.QUOTE_NONE)
                new_data = [hr[1],hr[2]]
                filewriter.writerow([str(datetime.now())]+new_data)
            self.DisplayHR.after(1000, self.ShowHRMonitor)

    def ScanDevices(self, event):
        self.window.destroy()

        self.window = Frame()
        self.window.pack()

        scanner = Scanner().withDelegate(ScanDelegate())
        devices = scanner.scan(2.0)

        self.names = {}
        for dev in devices:
            if isinstance(dev.getValueText(9), six.string_types) and "Polar" in dev.getValueText(9):
                self.names[dev.getValueText(9)] = dev.addr
        if len(self.names) == 0:
            self.window.destroy()

            self.window = Frame()
            self.window.pack()

            Label(self.window, text = '').pack()
            self.msg1 = Label(self.window, text="Nenhum sensor encontrado!")
            self.msg1.pack()

        else:
            Label(self.window, text = '').pack()
            self.msg1 = Label(self.window, text="Escolha seu device:")
            self.msg1.pack()

            self.menu = Combobox(self.window, values = list(self.names.keys()))
            self.menu.current(0)
            self.menu.pack()
            Label(self.window, text = '').pack()

            self.butConnect = Button(self.window, text="Conectar", width = 15)
            self.butConnect.pack()
            self.butConnect.bind("<Button-1>", self.ConnectDevice)
        
        Label(self.window, text = '').pack()
        self.butScan = Button(self.window, text="Buscar", width = 15)
        self.butScan.pack()
        self.butScan.bind("<Button-1>", self.ScanDevices)

def ntp_time():
    """
    Retorna a hora oficial do Brasil (NTP.br)

    Returns the official time of Brazil (NTP.br).
    """
    ntp_time = None
    client = NTPClient()
    servers = ['a.st1.ntp.br', 'b.st1.ntp.br', 'c.st1.ntp.br', 'd.st1.ntp.br']
    for host in servers:
        try:
            response = client.request(host)
            ntp_time = datetime.fromtimestamp(response.orig_time)
            break
        except (NTPException, socket.gaierror):
            pass

    return ntp_time


x = datetime.now()
y = ntp_time()
with open('sync.csv', 'a') as csvfile:
    filewriter = csv.writer(csvfile, delimiter=',', escapechar=' ', quoting=csv.QUOTE_NONE)
    filewriter.writerow(str(x) + str(y))


root = Tk()
root.title("HeRV")
root.minsize(300,400)
root.geometry("300x400")
Application(root)
root.mainloop()
