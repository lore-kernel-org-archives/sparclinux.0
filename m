From: Raphael Assenat <raph@raphnet.net>
Date: Mon, 10 Apr 2006 01:10:11 +0000
Subject: Re: Parallel port problems on Sun Ultra10
Message-Id: <20060410011011.GA22569@aramis.lan.raphnet.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1144596830.4439295e52873@imp1-g19.free.fr>
In-Reply-To: <1144596830.4439295e52873@imp1-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Apr 09, 2006 at 05:33:50PM +0200, Christophe Jacquet wrote:
> When I type " echo 'Hello world' >/dev/lp0 ", I get the message:
> 
> lp0: ECP mode
> 
> The string gets printed on the printer.
> 
> Then, Linux crashes. I get no more messages. The Bash prompt never comes back. I
> can interact with OBP by hitting "Stop-A", and reboot the machine.
Hi,
this reminds me of a problem I had a few week ago while playing with
an homebuild parallel port project. The machine would lock totally, but
as soon as I disconnected the circuit from the port the machine would
unlock. 

Maybe you could try disconnecting the printer and see what happens?

Here are more details about the problem I observed:

When the parallel port interrupt is enabled, the machine hangs as long as
the ACK pin is held low. I observed that the parport interrupt count in
/proc/interrupt were higher after each hang. 

It looks to me like the parport interrupt is level triggered instead 
of edge triggered. I wanted try on x86 hardware to see if the problem
also happens before posting, but I decided to post anyway when I saw
this message.

I observed this on a 2.6.16-rc6-git-something.

Regards,
Raphael Assenat
