From: "David S. Miller" <davem@redhat.com>
Date: Thu, 08 Apr 2004 20:17:23 +0000
Subject: Re: 2.6.5-mc2 switch_to() fix
Message-Id: <20040408131723.0c66030f.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040408122517.GD688@holomorphy.com>
In-Reply-To: <20040408122517.GD688@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 Apr 2004 13:16:56 -0700
Andrew Morton <akpm@osdl.org> wrote:

> @@ -15,6 +15,7 @@ SECTIONS
>    .text 0x0000000000404000 :
>    {
>      *(.text)
> +    SCHED_TEXT
>      *(.gnu.warning)
>    } =0
>    _etext = .;
> 
> Moving SCHED_TEXT to before .text should do it?

Actually, that might not work, since some of the trap table
and other stuff has to sit at the beginning to get aligned
correctly etc.

Ok, looks like wli's fix is the best for the time being until
I get a better idea :-)
