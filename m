From: "David S. Miller" <davem@redhat.com>
Date: Thu, 18 Mar 2004 23:03:35 +0000
Subject: Re: missing define for SNDRV_DMA_TYPE_PCI in 2.6.5_rc1
Message-Id: <20040318150335.79962e20.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0403161427310.7544@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0403161427310.7544@stargazer.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 16 Mar 2004 16:33:57 -0700 (MST)
Jason Wever <weeve@gentoo.org> wrote:

> I saw that there was a move to use SNDRV_DMA_TYPE_DEV 
> instead of SNDRV_DMA_TYPE_PCI, but that those changes hadn't been 
> incorporated into sound/sparc/cs4231.c.
> 
> The attached patch fixes that and actually works now.   Thanks for 
> tolerating me while i fumbled towards an answer. :)

That's the correct fix, yes.  Thanks Jason, I'll add your patch.
