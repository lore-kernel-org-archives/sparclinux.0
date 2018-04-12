From: David Rientjes <rientjes@google.com>
Date: Thu, 12 Apr 2018 20:46:36 +0000
Subject: Re: [PATCH v4] mm: remove odd HAVE_PTE_SPECIAL
Message-Id: <alpine.DEB.2.21.1804121346250.22780@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180411110936.GG23400@dhcp22.suse.cz>
 <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 12 Apr 2018, Laurent Dufour wrote:

> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
> CONFIG_ARCH_HAS_PTE_SPECIAL.
> 
> There is no functional change introduced by this patch
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
