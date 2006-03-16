From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 16 Mar 2006 22:44:46 +0000
Subject: Re: bbc, envctrl and sun blade 2000
Message-Id: <20060316.144446.10285680.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel 'NebuchadnezzaR' Dehennin <sparc@asgardr.info>
Date: Thu, 16 Mar 2006 19:28:15 +0100

> ebus0: [flashprom] [bbc] [ppm] [i2c -> (dimm-fru) (dimm-fru)
>        (dimm-fru) (dimm-fru) (nvram) (idprom)] [i2c -> (cpu-fru)
>        (temperature) (cpu-fru) (temperature) (fan-control)
>        (card-reader) (motherboard-fru) (i2c-bridge)] [beep] [audio]
>        [rtc] [gpio] [pmc] [floppy] [para llel] [serial]
> 
> So the bbc device is listed, recognised on ebus0 but the module can
> not load.
> 
> Do you have some hints ?

The kernel only allows the module to be loaded on platforms where we
know the driver will work instead of erasing your hard disk.  And
currently the list of known and tested cases is SunBlade 1000.
