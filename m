From: Kyle McMartin <kyle@infradead.org>
Date: Sun, 21 Dec 2008 20:45:01 +0000
Subject: Re: [PATCH] sparc: use .data.init_task section for
Message-Id: <20081221204501.GD12880@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081221204054.GA18284@uranus.ravnborg.org>
In-Reply-To: <20081221204054.GA18284@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 21, 2008 at 09:40:54PM +0100, Sam Ravnborg wrote:
> Use a dedicated aligned section for the init_thread_union
> variable and declare this section in vmlinux.lds.
> 
> This align sparc with most other architectures.
> Eventually this allow the init_task bits to be unified across all architectures.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Kyle McMartin <kyle@mcmartin.ca>
>

Thanks Sam!

I'm working on v2 of my init_task patchset, I'll try to post it to
linux-arch this evening or Monday.

cheers, Kyle
