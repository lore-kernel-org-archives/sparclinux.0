From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 27 Nov 2004 23:12:42 +0000
Subject: Re: [PATCH 2.6.9] Fix drivers/video/bw2.c compilation
Message-Id: <20041127151242.05c270a9.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041127111346.GA30214@darjeeling.triplehelix.org>
In-Reply-To: <20041127111346.GA30214@darjeeling.triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joshua Kwan <joshk@triplehelix.org>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sat, 27 Nov 2004 03:13:46 -0800
Joshua Kwan <joshk@triplehelix.org> wrote:

> Here's a patch that allows bw2.c to compile on 2.6.9, just redeclares a
> char* that suddenly went missing. Please apply.
> 
> Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

Fixed already in the current 2.6.10 sources, but thanks.
