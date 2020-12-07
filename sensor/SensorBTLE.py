import bluepy.btle as btle
import time
import numpy as np
import matplotlib.pyplot as plt
import struct

class HRMMNotificationsDelegate(btle.DefaultDelegate):
    """
     Delegate class will be set to handle hrmm notifications
     When notifications arrive, the HR value will be stored into bpm variable
    """
    def __init__(self):
        btle.DefaultDelegate.__init__(self)
        self.bpm = []
        self.rr = []

    def handleNotification(self, cHandle, data):
        try:
            self.bpm.append(ord(data[1]))
        except:
            self.bpm.append(data[1])
        # here we get the RR Interval, in uint16 format, in the first measure it is set to 0
        if(len(data) >= 4):
            self.rr.append(struct.unpack('H', data[2:4])[0])
        else:
            self.rr.append(0)

class HRMonitor:

    def __init__(self, mac):
        """
        Connects to the device via its mac address
        """
        hrm = 0
        try:
            self.hrm = btle.Peripheral(mac)
            #print("Connected to device")
        except:
            pass
            #print("Could not connect")
        self.configure()


    def configure(self):
        """
        Reads GATT specs and sets the handler for HR notifications
        Must be called upon initialization only
        """
        try:
            # read fixed ble specs for hrm service and hrmm characteristic
            hrmid = btle.AssignedNumbers.heart_rate
            hrmmid = btle.AssignedNumbers.heart_rate_measurement
            cccid = btle.AssignedNumbers.client_characteristic_configuration
            # query device for the service (hrm), characteristics and descriptors
            serv = self.hrm.getServiceByUUID(hrmid)
            chars = serv.getCharacteristics(hrmmid)[0]
            desc = self.hrm.getDescriptors(serv.hndStart, serv.hndEnd)
            d = [d for d in desc if d.uuid==cccid][0]
            #self.hrm.writeCharacteristic(d.handle, '\1\0')
            self.hrm.writeCharacteristic(d.handle, '\1\0'.encode())
            self.hrm.setDelegate(HRMMNotificationsDelegate())
            self.t0 = time.time()
            # print("Ready to receive")
        except:
            print("Could not initialize device!")
            self.hrm.disconnect()

    def readHR(self):
        """
        Returns a tuple with relative time and HR for the last HR received
        This is supposed to be called inside a loop
        The full list of HRs received can still be accessed in self.bpm
        """
        self.hrm.waitForNotifications(600.0)
        hrkey = time.time()-self.t0
        hrvalue = self.hrm.delegate.bpm[-1]
        rrvalue = self.hrm.delegate.rr[-1]
        return (hrkey, hrvalue, rrvalue)

    def finish(self):
        self.hrm.disconnect()



def readAndPlot(polar, n):

    plt.ion() # Allows the graph to update
    fig = plt.figure()
    plt.axis([0,n,50,200])
    x = list()
    y = list()
    for i in range(n):
        hr = polar.readHR()
        print("[%.2f]"%(hr[0]), hr[1])
        x.append(hr[0])
        y.append(hr[1])
        plt.scatter(hr[0], hr[1])
        plt.show()
        plt.pause(0.0001) # Allows the graph to refresh



if __name__ == '__main__':
    mac = "00:22:D0:85:88:8E" 
    #mac = '00:22:D0:B8:61:CA' # Carlos
    polar = HRMonitor(mac)
    readAndPlot(polar, 10)
    polar.finish()
