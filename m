From: David Miller <davem@davemloft.net>
Date: Tue, 21 Aug 2018 19:40:43 +0000
Subject: Re: [PATCH v2 0/3] sparc32: switch to NO_BOOTMEM
Message-Id: <20180821.124043.1345592906200206631.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1533552755-16679-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rppt@linux.vnet.ibm.com
Cc: sam@ravnborg.org, mhocko@kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon,  6 Aug 2018 13:52:32 +0300

> These patches convert sparc32 to use memblock + nobootmem.
> I've made the conversion as simple as possible, just enough to allow moving
> HAVE_MEMBLOCK and NO_BOOTMEM to the common SPARC configuration.
> 
> v2 changes:
> * split whitespace changes to a separate patch
> * address Sam's comments [1]
> 
> [1] https://lkml.org/lkml/2018/8/2/403

Series applied, thank you.
