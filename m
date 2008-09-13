From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 18:04:27 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913180427.GA17882@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Sep 13, 2008 at 07:49:45PM +0200, Josip Rodin wrote:
> After being put into the v240, they reliably stop working :/

Errrr, in another round of sparcs screwing with my mind :) I have almost
accidentally gotten one combination to work - I plugged both ends of the
cable into the Oxford card, and established communication between ttyS2 and
ttyS3.

That can't be right...

% dmesg | grep 'ttyS[23]'
0001:00:03.0: ttyS2 at I/O 0x10009a0 (irq = 20) is a 16550A
0001:00:03.0: ttyS3 at I/O 0x10009a8 (irq = 20) is a 16550A

% sudo lspci -s 0001:00:03.0 
0001:00:03.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01)

Uhh.

Then I went back to the machine, opened it up (live) and made physically
sure that the cables were indeed plugged into the Oxford card. Software
is wrong, I swear! :)

Then I tried to experiment with plugging both ends of the cable into the
(physical) Timedia card, and connecting minicoms via ttyS0 and ttyS1 -
but that did not work.

Dave, I hope you can make sense of all this... you have the prtconf of the
machine in the repository so you can see which PCI controller that is.
If you need any more details, please don't hesitate to let me know.

-- 
     2. That which causes joy or happiness.
