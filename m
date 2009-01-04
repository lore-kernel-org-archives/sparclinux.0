From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 04 Jan 2009 08:43:55 +0000
Subject: Re: [PATCH] sparc: Merge sparc_ksyms_{32,64}.c
Message-Id: <20090104084355.GB31198@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4960225E.1000801@gmail.com>
In-Reply-To: <4960225E.1000801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Julian.

As a first step before trying to merge these two files
all EXPORT_SYMBOL() that exports symbols defined in .C files
shall be moved out to their respective definition site.

So when you see:

sparc_ksyms.c:
EXPORT_SYMBOL(foobar);

foo.c:

int foobar(int bar)
{
	...
}
EXPORT_SYMBOL(foobar);   <= This is the line you shall add

Notice that we put the EXPORT_SYMBOL right after the closing '}'
with no blank lines in-between.

You also need to pay attention to all the
prototypes and extern's in the sparc_kysms.c files.

If they are still needed they belong to a header file.
We have today:

entry.h - this is all the functions defined in .S files
          It has a common part and a sparc32 and a sparc64 specific part

kernel.h - this is all prototypes defined in arch/sparc/kernel/ and
not used outside arch/sparc/kernel/.

But some of them will naturally no longer be used.

   extern spinlock_t rtc_lock;

is only contained in sparc_ksyms_*.c because the EXPORT_SYMBOL()
is there. When you move the EXPORT_SYMBOL to the respective
file time_32.c then you no longer need the extern in sparc_ksym_32.c

And look after unused stuff too. I noticed struct poll seems
unused.

This is all straightforward to do it just take some time.
And if you keep your patches sufficienly small then it
should be easy to review too.

	Sam
