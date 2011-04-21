From: daniel@gaisler.com
Date: Thu, 21 Apr 2011 18:50:02 +0000
Subject: Re: [PATCH] sparc32: avoid build warning at mm/percpu.c:1647
Message-Id: <20110421145002.ziztqqi3okk40kws@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303293448-13168-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303293448-13168-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Thu, 21 Apr 2011 11:03:56 -0700 (PDT), David Miller  wrote:
From: Daniel Hellstrom <daniel@gaisler.com>
> Date: Wed, 20 Apr 2011 11:57:28 +0200
>
> > Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>
> So please use the mechanism we have in place to handle this problem,
> include linux/const.h and use the AC() macros as we do in pgtable_64.h
> for this. 

Had forgotten that, will try to resend it tomorrow... unless Sam is quicker :)

Daniel


