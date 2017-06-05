From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 19:01:30 +0000
Subject: Re: [PATCH] sparc/mm/hugepages: Fix setup_hugepagesz for invalid values.
Message-Id: <20170605.150130.91487235108943900.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Tue, 30 May 2017 15:45:00 -0400

> hugetlb_bad_size needs to be called on invalid values.  Also change the
> pr_warn to a pr_err to better align with other platforms.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Applied and queued up for -stable, thanks.
