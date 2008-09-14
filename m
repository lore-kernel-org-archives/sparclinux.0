From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 14 Sep 2008 10:52:05 +0000
Subject: Re: 16550 serial support
Message-Id: <20080914105205.GA7810@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Sep 13, 2008 at 09:18:52PM -0700, David Miller wrote:
> Those indexes "0", "1", etc. are within the namespace of the device
> type itself.  It does not determine which ttyS? device index these
> things gets hooked up to. [...]

OK, I was hoping for that, but it didn't seem to be that way in practice.

> You probably have something that looks like:
> 
> sunsu                /dev/ttyS       4 64-65 serial
> serial               /dev/ttyS       4 66-69 serial
> 
> which would match up with my predictions above.  /dev/ttyS0 uses
> device minor 64, /dev/ttyS1 gets minor 65, etc.

Yes, you're right, /proc/tty/drivers does say that.

-- 
     2. That which causes joy or happiness.
