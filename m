From: Nathan Fontenot <nfont@austin.ibm.com>
Date: Tue, 10 Nov 2009 20:33:51 +0000
Subject: Re: [PATCH 09/11] of: merge prom_{add,remove,modify}_property
Message-Id: <4AF9CE2F.7080502@austin.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua> <20091105074656.10460.29333.stgit@angua>
In-Reply-To: <20091105074656.10460.29333.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au

Grant Likely wrote:
> Merge common code between PowerPC and MicroBlaze
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/microblaze/kernel/prom.c |  113 ----------------------------------------
>  arch/powerpc/kernel/prom.c    |  114 ----------------------------------------
>  drivers/of/base.c             |  116 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+), 227 deletions(-)
> 

Should the prom_{add,remove,update}_property routines belong in base.c or
of_dynamic.c (patches coming soon for of_dynamic.c)?  

My original patch set put these routines in of_dynamic.c and renamed
them to of_{add,remove,update}_property since they are part of the of
code.

-Nathan Fontenot
