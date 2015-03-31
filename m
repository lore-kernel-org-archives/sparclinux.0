From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 31 Mar 2015 18:06:42 +0000
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <20150331180642.GA13314@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1427761300.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On (03/31/15 10:40), Sowmini Varadhan wrote:
> 
> I've not heard back from the IB folks, but I'm going to make
> a judgement call here and go with the spin_lock. *If* they
> report some significant benefit from the trylock, probably 
> need to revisit this (and then probably start by re-exmaining
> the hash function to avoid collisions, before resorting to 
> trylock).

Having bravely said that..

the IB team informs me that they see a 10% degradation using 
the spin_lock as opposed to the trylock.

one path going forward is to continue processing this patch-set 
as is. I can investigate this further, and later revise the spin_lock
to the trylock, after we are certain that it is good/necessary.

thoughts?

--Sowmini


