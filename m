From: Vladislav Bolkhovitin <vst@vlnb.net>
Date: Wed, 16 Jun 2010 19:08:03 +0000
Subject: How to printk/sprintf uint64_t on Sparc without format and argument
Message-Id: <4C192113.7030101@vlnb.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTimuv7nOlcGFxqPZlwcAjLmFMiLAvbA5O7F32Wbg@mail.gmail.com>
In-Reply-To: <AANLkTimuv7nOlcGFxqPZlwcAjLmFMiLAvbA5O7F32Wbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org
Cc: Simone Ricci <simone.ricci@gmail.com>, scst-devel@lists.sourceforge.net, Joe Eykholt <jeykholt@cisco.com>, linux-kernel <linux-kernel@vger.kernel.org>

Hello,

We in SCST project need to printk/sprintf variables of type uint64_t.=20
Size of those variables is required to be 64-bit integer. On x86 we=20
printk/sprintf them as %lld, but on Sparc we have a compiler warnings like:

scst/src/scst_targ.c:2136: warning: format =91%llx=92 expects type =91long =

long unsigned int=92, but argument 4 has type =91uint64_t=92.

It is because on Sparc uint64_t defined as unsigned long, but on x86 -=20
as unsigned long long.

Sure, we can cast all the cases to unsigned long long, but we wonder,=20
maybe there is a more elegant way to do that without the warning? For=20
instance, like %z for size_t or PRId64 in the user space.

Thanks,
Vlad

