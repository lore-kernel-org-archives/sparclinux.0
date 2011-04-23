From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 23 Apr 2011 17:42:00 +0000
Subject: memblock versus bootmem (relevant for sparc32?)
Message-Id: <20110423174200.GA25324@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Ben, Yinghai, Ingo.

While doing some sparc related tasks I noticed that sparc64
uses memblock - whereas sparc32 does not.

I am aware that memblock was called lmb in the older days and
that sparc64 had lmb support which was converted to memblock support.

But so far I have failed to find any information on what the benefit
of memblock is and how it compared to for example bootmem.
I can see that x86 no longer uses bootmem - as the only arch.

But I also noticed that mm/nobootmem.c contains several functions
named bla_x86_bla(). So I continued to be a bit confused.

Do there exist any writeup of what memblock is?

Also does it make sense to consider introducing memblock for sparc32.
And if yes - what is the benefit and what does it replace?

And would it make sense to drop bootmem on sparc64?

I know - lots of questions!

	Sam
