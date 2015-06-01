From: Alexander Graf <agraf@suse.de>
Date: Mon, 01 Jun 2015 11:38:44 +0000
Subject: Re: [PATCH] treewide: Fix typo compatability -> compatibility
Message-Id: <556C4444.4070808@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1432728342-32748-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1432728342-32748-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On 27.05.15 14:05, Laurent Pinchart wrote:
> Even though 'compatability' has a dedicated entry in the Wiktionary,
> it's listed as 'Mispelling of compatibility'. Fix it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/metag/include/asm/elf.h             | 2 +-


>  arch/powerpc/kvm/book3s.c                | 2 +-

Acked-by: Alexander Graf <agraf@suse.de>

for the PPC KVM bit.


Alex
