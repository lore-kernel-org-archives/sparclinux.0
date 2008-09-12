From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 18:36:40 +0000
Subject: Re: 16550 serial support
Message-Id: <20080912183640.GA15219@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 12, 2008 at 11:35:08AM +0200, Josip Rodin wrote:
> OK, this is strange, now the loading attempt hangs. stracing it shows
> looping...
> 8250 29680 1 - Loading 0x0000000010054000

Unloading the module also didn't work the same way... so I figured it might
be another unclean upgrade issue, so I rebooted it to see what happens when
I start from scratch - and then a much more serious problem arose: at the
point during the boot sequence when udev detected and loaded the modules,
the machine reproducibly crashes (tried it twice in a row).

The serial console seems to gets jumbled because the error message
overwrites the last few lines, and then the ALOM prints its reset notice
on top of the screen. This is my reproduction of the last output:

Serial: 8250/16550 driver4 ports, IRQ sharing disabled
[a couple of assorted messages from tg3]

Fatal Error Reset

CPU 0000.0000.0000.0000 AFSR 0080.0000.0000.0000  JEIC
AFAR 0000.0000.0000.0000

SC Alert: Host System has Reset

-- 
     2. That which causes joy or happiness.
