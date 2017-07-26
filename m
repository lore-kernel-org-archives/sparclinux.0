From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 16:46:43 +0000
Subject: Re: [PATCH 08/11] sparc64/topology: Remove the unused parent_node() macro
Message-Id: <20170726.094643.1039464323275979489.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
        <1501076076-1974-9-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1501076076-1974-9-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: douly.fnst@cn.fujitsu.com
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, sparclinux@vger.kernel.org

From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 21:34:33 +0800

> Commit a7be6e5a7f8d ("mm: drop useless local parameters of
> __register_one_node()") removes the last user of parent_node().
> 
> The parent_node() macro in SPARC64 platform is unnecessary.
> 
> Remove it for cleanup.
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Acked-by: David S. Miller <davem@davemloft.net>
