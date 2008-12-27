From: David Miller <davem@davemloft.net>
Date: Sat, 27 Dec 2008 08:35:23 +0000
Subject: Re: [PATCH] sparc: use .data.init_task section for
Message-Id: <20081227.003523.164458105.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081221204054.GA18284@uranus.ravnborg.org>
In-Reply-To: <20081221204054.GA18284@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Dec 2008 21:40:54 +0100

> Use a dedicated aligned section for the init_thread_union
> variable and declare this section in vmlinux.lds.
> 
> This align sparc with most other architectures.
> Eventually this allow the init_task bits to be unified across all architectures.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
