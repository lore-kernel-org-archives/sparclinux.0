From: Raymond Burns <rayburns@comcast.net>
Date: Tue, 18 Jul 2006 19:49:16 +0000
Subject: Re: sparc32 git tree
Message-Id: <Pine.LNX.4.10.10607180036011.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 17 Jul 2006, David Miller wrote:

> It's dumping into the firmware on cpu #4.
> 
> Why don't you try a non-SMP kernel while we work out these
> device level problems?  This crash here might be related
> to the erroneous SLAB patch you put in there.

compiled as non-SMP, the recovering cpu is #0, the logged result
persists.

ctrace showed an interesting thought, I anotated with the System map
values.

udelay is the only place I see getting to .umul and not sure what it's
choking on ( 5 isn't that exotic ).

no I haven't been playing in lib/umul.S

Thanx
  Ray


