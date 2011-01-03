From: Frans van Berckel <fberckel@xs4all.nl>
Date: Mon, 03 Jan 2011 16:07:22 +0000
Subject: Sun Fire V440 fan control
Message-Id: <1294070842.1549.53.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

What kernel module do i need to compile for controlling the fan's in a
Sun Fire V440? And has anyone experience and got it to lower the speed?

# find /proc/openprom -name temperature*
# cd /proc/openprom/pci@1e,600000/isa@7/i2c@0,320
# cat compatible
pcf8584
# cat hardware-monitor@0,5c/compatible
i2c-adm1026
# cat i2c-bridge@0,16/compatible
SUNW,i2c-imax
# cat i2c-bridge@0,18/compatible
SUNW,i2c-imax
# cat temperature@0,30/compatible 
i2c-max1617
# cat temperature@0,64/compatible 
i2c-max1617
# cat temperature@0,80/compatible 
i2c-max1617
# cat temperature@0,90/compatible 
i2c-max1617
# cat temperature-sensor@0,9c/compatible
i2c-lm75

