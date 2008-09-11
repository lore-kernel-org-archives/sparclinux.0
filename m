From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 11 Sep 2008 14:31:46 +0000
Subject: 16550 serial support
Message-Id: <20080911143146.GA24923@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Here's me with my dunce hat yet again...

I wanted to add serial ports to a Fire v240 (so that I can connect the
Fire 280R's serial console cable to it). So I went to the nearest shop
and bought a PCI card with a couple of RS-232 ports. It is identified by
lspci as:

0001:00:02.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01)

But then I noticed that no kernel module detected this, and that
SERIAL_8250 depends on (BROKEN || !SPARC). Googling didn't help much,
most users installed this in PCs and it seems everything worked for them
(apart from an occasional setserial(8)-related complaint).

Is this then completely unsupported, supported by a different part of
the kernel (sunsu, sunsab?), or?

-- 
     2. That which causes joy or happiness.
