From: David Miller <davem@davemloft.net>
Date: Tue, 31 Mar 2015 18:08:48 +0000
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <20150331.140848.1629977835564626654.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <20150331180642.GA13314@oracle.com>
In-Reply-To: <20150331180642.GA13314@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 31 Mar 2015 14:06:42 -0400

> Having bravely said that..
> 
> the IB team informs me that they see a 10% degradation using 
> the spin_lock as opposed to the trylock.
> 
> one path going forward is to continue processing this patch-set 
> as is. I can investigate this further, and later revise the spin_lock
> to the trylock, after we are certain that it is good/necessary.
> 
> thoughts?

Let's address the trylock vs. spin_lock thing later and use plain
spin_lock for now.
