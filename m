From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 19:43:47 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <5709c59a-0208-73dd-a00c-644fa1af4f38@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/19/2017 09:16 PM, Eric Saint Etienne wrote:
>> Not "we", you. You are refusing to make progress and that's frustrating,
>> especially for all the folk from Oracle who are sending in patches all
>> the time.
>
> Let's keep a cool head here, please. Nobody can and want to force Dave to expose mdesc on sysfs if he doesn't want to.

My point is: Dave shouldn't make decisions solely based on his personal preferences
when he's making decisions that affect all users of Linux on SPARC.

We're already having some trouble to gain a reasonable amount of users and we will
not be able to make Linux on SPARC more attractive if the reference standard is
32-bit SPARC on Gentoo without any proper security support [1].

We have many Debian users who want to install Linux on their SPARC boxes. But
not all of them are hardcore experts that can deal with 15-year-old userland
tools which no one knows anymore these days and which they have to Google
search first before they can download, build and install them.
  
> At the end of the day, users who want to expose mdesc on sysfs can download
> and apply the patch since it will be forever available on the sparclinux
> mailing list archives.

Assuming that most users know how to compile their own kernel.

It's similar to the situation with the SPARC patches for GRUB. Eric has invested
lots of time and efforts to get SPARC support in GRUB back into shape so that
it works well on modern hardware with GPT partition tables, 64-bit support
and so on. Most of his patches haven't been merged to date because the GRUB
maintainers can't be bothered to have a look at them. Yes, you can grab these
patches, merge them to GRUB locally and build your own GRUB package. But that's
not what the majority of users even know how to do.

This attitude is what keeps Linux on SPARC back. If you want Linux on SPARC
to me more popular, you need it to be more user-friendly. Users expect
a certain set of features and tools these days if they want to install a Linux
distribution and that includes support for modern bootloaders and a standardized,
easily parsable system information interface and so on.

The world has moved on and users use their hardware differently these days,
that includes tools like Puppet and Ansible as Anatoly mentioned in his mail.

Adrian

> [1] https://lwn.net/Articles/724700/

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
