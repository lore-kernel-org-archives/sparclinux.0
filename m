From: Ben Collins <bcollins@debian.org>
Date: Mon, 12 Jan 2004 16:13:46 +0000
Subject: Re: Linux on a SUN E5500
Message-Id: <20040112161346.GT31486@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200401101839.58257.hemstock@tiscali.co.uk>
In-Reply-To: <200401101839.58257.hemstock@tiscali.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Fore ATM SBA-200
> HVD SCSI C479929A73722
> Fibre channel Vixel OE1063SV 370233012343
> 
> I have tried to install Debian on this however, it boots the installer and 
> then tells me that there are no disks found.  I'm not sure where to go from 
> here.  There are a few hardware problems with the box.  I have tried to 
> install SuSE and it hangs and Solaris reports memory errors.  I need to do 
> some hardware fixing, but I'd like to get a general finger in the air of what 
> to expect when trying to build this box.  Does anyone think that Debian will 
> support the hardware?  What is the best Sparc Linux for E5500?  Basically I 
> just need some advise on getting started.

Debian supports the hardware, but I don't think any of the storage cards
are built-in to the kernel. You may have to do some hand made root image
based the Debian initrd for the install. Just copy the modules on to it,
and get things going that way.

There's not really a "best dist for box FOO", since they all use the
same kernel, and generally support the same thing.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
