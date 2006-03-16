From: "Daniel 'NebuchadnezzaR' Dehennin" <sparc@asgardr.info>
Date: Thu, 16 Mar 2006 21:37:37 +0000
Subject: bbc, envctrl and sun blade 2000
Message-Id: <87hd5yoyu6.fsf@thorr.asgardr.info>
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hello,

I recently install a debian on a SunBlade 2000, using etch netinstall
because sarge one do not handle USB keyboard.

After finding that I need to load qlogiqfc on tty2 to see my disk in
the partition tool, and to /etc/yaird/Default.cfg, my debian is
running.

CPUFreq works but there is no control on the fans and CPU temperature.

I try to modprobe bbc and envctrl but the answer is "no such device".

dmesg show me this:

ebus0: [flashprom] [bbc] [ppm] [i2c -> (dimm-fru) (dimm-fru)
       (dimm-fru) (dimm-fru) (nvram) (idprom)] [i2c -> (cpu-fru)
       (temperature) (cpu-fru) (temperature) (fan-control)
       (card-reader) (motherboard-fru) (i2c-bridge)] [beep] [audio]
       [rtc] [gpio] [pmc] [floppy] [para llel] [serial]

So the bbc device is listed, recognised on ebus0 but the module can
not load.

Do you have some hints ?

I try 2.6.15 from debian, 2.6.15.6 from kernel.org and 2.6.16-rc6 from
kernel.org.

Regards.
-- 
Daniel 'NebuchadnezzaR' Dehennin
Récupérer ma clef GPG:
gpg --keyserver pgp.mit.edu --recv-keys 0x2A408F69
