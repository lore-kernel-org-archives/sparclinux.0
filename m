From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 31 Dec 2010 11:18:36 +0000
Subject: Re: [PATCH 0/5] sparc: piggyback update
Message-Id: <20101231111836.GA9941@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20101231093628.GA19496@merkur.ravnborg.org>
In-Reply-To: <20101231093628.GA19496@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> My idea was to create a unified piggyback that took $BITS as an
> argument - then did sensible things based upon that. It never got off
> the ground here.

Rather then doing code-chrunch in piggyback_64 we should add this
extra argumant and then let piggyback_32 handle both the 32 and 64 bit
case.

The few things that differs is:
1) Check lookup of _start, _end
2) Start address of added image is on different addrees alignemnts (4096 / 8192)
3) sparc64 uses host endian when it stores data in the image (looks lige a bug)
4) sparc64 updates a_text, a_data and a_bss in the a.out header - sparc32 does not.
   And I could not figure out the expression used to calculate a_text value..

All in all simple differences.
But as my sparc64 box is not yet alive I postponed it until
I could actually test it.

	Sam
