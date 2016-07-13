From: David Miller <davem@davemloft.net>
Date: Wed, 13 Jul 2016 21:52:52 +0000
Subject: Re: Mapping PADDR into virtual memory problem.
Message-Id: <20160713.145252.2232921242877114390.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4701cc90-2a15-0ab9-3527-170ce306a51d@oracle.com>
In-Reply-To: <4701cc90-2a15-0ab9-3527-170ce306a51d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


vread() always provides all zeros for VM_IOREMAP areas.
