From: Dennis Jenkins <dennis.jenkins@sbcglobal.net>
Date: Thu, 03 Mar 2005 17:19:40 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050303171940.99105.qmail@web81304.mail.yahoo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thank you for your response!  Details below.

ps- I'm at work.  My box is at home.  The details
given below are from memory.

My box specs: 8 processor E3500 (336MHz), 10G ram, 8x
18.2G fiber channel drives in the 3500 chassis, and an
external A3500 raid array with 35x 9.1G scsi disks.
Linux can see the A3500, but I had to use Solaris to
configure the raid array initially.  It came with 40
drives, but 5 are bad. :(

I added one 18.2G scsi drive on the same channel as
the CDROM (I have Linux on this one).  Openboot prom
can boot Linux (gentoo, kernel 2.4.29) and Solaris 10
successfully.

I picked up my box from a company that was going out
of business.  They had no idea what it was worth.  I
spent much less than $500 for the whole thing.

--- Chris Newport <crn@netunix.com> wrote:
> First check if you should be using the soc or socal
> drivers.
> A handbook search at sunsolve for the barcode on
> your board will
> tell you if it is FC/25 or FCAL - just take the
> first 7 chars and insert
> a dash like this 501-1234.  The  SSA1xx  arrays with
> 3 pull-out drawers
> each containing 10 drives need the soc card and
> drivers. Later arrays 
> such as the A5000 need the socal card and drivers.

socal.  I don't remember how I determined this, but I
did read the documents on the difference between "soc"
and "socal".  The system is definitely NOT an FC/25.

"probe-fcal-all" from openprom sees all 8 drives.  I
have Solaris 10 installed on the first drive.

> The soc/pluto stuff has not been maintained since
> 2.2.x and AFAIK this 
> is also true for socal.

Yup, I read that too.  And immediately there after I
downloaded the last 2.2 kernel and tried to compile
it.  Unfortunately for me, GCC 3.3.5 choked heavily on
it.  I will try again when I figure out how to get
Gentoo to downgrade gcc.  The question is, what
version should I downgrade to?

> Take a look at http://www.splack.org/fibrechan.html

Thanks for the URL!  I will try that procedure soon.

> for the lowdown on
> how to get soc working on 2.2.x, once you have that
> working it should
> be possible to port the existing drivers to 2.4 and
> then 2.6.

I figured that if I could get the socal drive working
on 2.2.x, then I could try to port the changes to 2.4.

I extracted the socal firmware from Solaris 10.  I
then used a perl script (someone else wrote it) to
convert the firmware into the "socal_asm.h" header
file.  I then modified "drivers/fc4/socal.c" to use
the new firmware (in kernel 2.4.29).  This made the
"port A, Port B" error messages go away, but I still
can't see the drives.  Then again, it is known that
socal does not work in the 2.4 series.

My bigger question is, how do I know that I correctly
prepared the socal_asm.h file?  If I post the MD5
checksum of the "socal_ucode" that I extracted from
solaris, can someone here verify that I have the
correct 64K chunk of junk?

I have no idea if I can legally post the first few
lines of the "socal_asm.h" file.  I assume that I can
under the fair use doctrine, but these days..... no
clue.

Thank you for your help.

pss- If someone with more kernel hacking skills than I
wants to try to fix this problem, I'll work with you
to  share my hardware, virtually.  ie, you get root on
the box (it is behind a firewall that monitors inbound
and outbound traffic) and can play away!

psss- This offer is for a legitimate, established,
sparc/linux/kernel programmers whose name and email
address appear in kernel credits or as a trustworthy
individual on this list.  I've never before opened up
any of my boxes to anyone that I did not know
personally.  I don't want my teeny DSL connection used
to commit crimes, etc... :)


==Dennis Jenkins
