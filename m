From: "David S. Miller" <davem@redhat.com>
Date: Fri, 09 Apr 2004 23:30:25 +0000
Subject: Re: [PATCH] Add amd7930 to include/sound/sndmagic.h
Message-Id: <20040409163025.13d5c527.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040405231229.4ae000fe@enterprise.weeve.org>
In-Reply-To: <20040405231229.4ae000fe@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 5 Apr 2004 23:12:29 -0600
Jason Wever <weeve@gentoo.org> wrote:

> The included patch adds amd7930 to the include/sound/sndmagic.h in 2.6,
> allowing the sun-snd-amd7930 driver to build.
> 
> According to the ALSA doc about writing drivers, the define in sndmagic.h
> doesn't need to be a particular value as long as it is
> unique, so that is what I did here.

Applied, thanks Jason.

Hey, can you "-p1" root your patches in the future?  That will
save me a little bit of work and get your changes installed
faster as a result :-)

Thanks again.
