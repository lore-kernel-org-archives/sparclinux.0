From: Patrick Finnegan <pat@computer-refuge.org>
Date: Sat, 15 May 2004 17:10:36 +0000
Subject: Re: [LONG] Problem with Sun Enterprise 450 and kernel 2.6.X
Message-Id: <200405151210.36229.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58L.0405151812370.18060@alpha.zarz.agh.edu.pl>
In-Reply-To: <Pine.LNX.4.58L.0405151812370.18060@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Saturday 15 May 2004 11:20, you wrote:
> Remapping kernel ...
> Booting Linux ....
>
> and ... nothing more.
> I try to wait 20 min for start, but nothing.

Try to boot with the "-p" kernel option.  This will cause "early printk" 
to be available, so that messages/errors before the console is 
initialized will be available.

I had an issue like this with my E3000, and it turned out to be a small 
kernel bug combined with the fact that I had set NR_CPUS too small in 
the kernel config, however, I don't think that you should have that 
problem with your E450.

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
