From: "C.Newport" <crn@netunix.com>
Date: Mon, 12 Jan 2004 23:57:15 +0000
Subject: Re: Linux on a SUN E5500
Message-Id: <200401122357.15575.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200401101839.58257.hemstock@tiscali.co.uk>
In-Reply-To: <200401101839.58257.hemstock@tiscali.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Saturday 10 January 2004 6:39 pm, Mike Hemstock wrote:
> Hi folks,
>
> We have bits of SUN kit lying around at work and I've assembled them to
> make an E5500.  The box has the following:
>
> 2x StorEdge D1000 HVD disk carriers with 4 9.1Gb SCSI disks a piece
> 1x Fibrechannel Enterprise Network Array with 4 9.1Gb disks
> Single Ended SCSI IO card 270-3113-30 Rev S 5013113006645
>
> Sbus IO card with:
>
> Fore ATM SBA-200
> HVD SCSI C479929A73722
> Fibre channel Vixel OE1063SV 370233012343
>
> I have tried to install Debian on this however, it boots the installer and
> then tells me that there are no disks found.  I'm not sure where to go from
> here.  There are a few hardware problems with the box.  I have tried to
> install SuSE and it hangs and Solaris reports memory errors.  I need to do
> some hardware fixing, but I'd like to get a general finger in the air of
> what to expect when trying to build this box.  Does anyone think that
> Debian will support the hardware?  What is the best Sparc Linux for E5500? 
> Basically I just need some advise on getting started.

Your first job is to check out the memory errors.
First get to an OBP ok prompt.
test-memory-all should check the memory. You probably have plenty,
to you could just remove a faulty bank. A handbook search at 
http://sunsolve.sun.com/ for E5500 memory should get you to a
diagram showing which banks are which.

printenv will list the environment settings, what does boot-device say ?
Next run probe-sci to list the devices on the default bus.
Then run probe-scsi-all to list all devices.

Where are you in the UK, I may be able to help, I am near Bristol.
If I know exactly what is happening I should be able to cut a custom
Splack install CD for your environment.


