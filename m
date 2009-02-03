From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 03 Feb 2009 00:49:38 +0000
Subject: Re: make ARCH=sparc allmodconfig change
Message-Id: <Pine.LNX.4.61.0902022326200.15354@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20090201190029.GA8962@x200.localdomain>
In-Reply-To: <20090201190029.GA8962@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi All,

On Tue, 3 Feb 2009, Julian Calaby wrote:

> On Mon, Feb 2, 2009 at 16:48, Sam Ravnborg <sam@ravnborg.org> wrote:
>> On Sun, Feb 01, 2009 at 09:51:13PM +0000, Mark Fortescue wrote:
>>> Hi all.
>>>
>>> Silly question. If ARCH=sparc is not 64bit then how do you make a 32bit
>>> sparc kernel?
>>
>> make arch=sparc menuconfig give you the option to select
>> if the kernel is 64 bit or not.
>>
>> And this "64 bit?" option is what is causing us troubles for the
>> all*config targets.
>> allyesconfig and allmodconfig will both set this option to 'y'
>> so we cannot in any simple way generate a 32bit all{yes,mod}config.
>
> Why not have a sparc32 arch also, which would force 64bit to false. So:
> 1. If we detect a 32 bit sparc, we select sparc32.
> 2. If we detect a 64 bit sparc, we select sparc64.
> 3. Otherwise we select sparc and let the user decide.
>
> I believe that powerpc also works in this manner, as does x86.

I always cross compile as building on a sun4c takes days so detection is 
not an option. 
Having an ARCH alias to preset the 32/64bit flag would seem to me to make 
sence i.e.:

ARCH=sparc would give the current or previous characteristics (see below)
ARCH=sparc32 would overide CONFIG_64BIT to N (is not set)
ARCH=sparc64 would overide CONFIG_64BIT to Y

Using a 2.6.28.3 kernel source tree for reference (my sparc git trees are 
on a machine that is not turned on at the moment):

The current toplevel Makefile explicitaly processes the x86 alias. This 
could be changed to use a small script/alias file (so that, where 
apropriate for other architectures, it can easilly be extended) to get 
SRCARCH e.g.:

SRCARCH=$(shell $(srctree)/scripts/get_srcarch $(ARCH))

get_srcarch could use a simple 'case $1 in' statement get SRCARCH 
e.g.:

#! /bin/sh
case "$1" in
   # ARCH             SRCARCH
   i386)		echo "x86"   ;;
   x86_64)	echo "x86"   ;;
   sparc32)	echo "sparc" ;;
   sparc64)	echo "sparc" ;;
   *)            echo "$1"    ;;
esac

In the arch/sparc/Kconfig some alterations would be needed to get the 
desired overriding of CONFIG_64BIT. Maybe somthing like:

# Select 32 or 64 bit
config 64BIT
 	bool "64-bit kernel" if ARCH = "sparc"
 	default ARCH = "sparc64"
#       default !(ARCH = "sparc32") would be an alternative
 	help
 	  Say yes to build a 64-bit kernel - formerly known as sparc64
 	  Say no to build a 32-bit kernel - formerly known as sparc

Sam, given your work on the sparc32/64 merge, you probably know your 
way arround recent changes and the current plans for the future a 
lot better than I ever will. Would this set of ideas be somthing that 
would be in keeping with current plans?

If you think it worth while, I could probably find a few hours this week 
to generate a patch along these lines and do some simple testing.

Regards
 	Mark.
