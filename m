From: David Miller <davem@davemloft.net>
Date: Tue, 16 Sep 2008 18:48:19 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <20080916.114819.78467821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Elad Lahav <elahav@uwaterloo.ca>
Date: Tue, 16 Sep 2008 14:47:39 -0400

> If proc_id is used by the scheduler and is supposed to indicate the
> internal core arrangement, then cpu_data should have an extra
> phys_proc_id field, similar to other architectures (which would then
> be exported via physical_package_id).

The cpumasks are used by the scheduler to build the scheduler
to build the scheduler domain.

But, yes, those are built based upon the proc_id and core_id
values.
