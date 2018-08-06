From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 06 Aug 2018 13:08:39 +0000
Subject: Re: [PATCH v2 2/3] sparc32: switch to NO_BOOTMEM
Message-Id: <20180806130839.GA23652@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1533552755-16679-3-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1533552755-16679-3-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:52:34PM +0300, Mike Rapoport wrote:
> Each populated sparc_phys_bank is added to memblock.memory. The
> reserve_bootmem() calls are replaced with memblock_reserve(), and the
> bootmem bitmap initialization is droppped.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
