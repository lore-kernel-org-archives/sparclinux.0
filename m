From: David Miller <davem@davemloft.net>
Date: Wed, 28 Sep 2016 15:30:26 +0000
Subject: Re: [PATCH 1/2] sparc64: Fix cpu_possible_mask if nr_cpus is set
Message-Id: <20160928.113026.2141670672032604099.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1473972881-10671-2-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1473972881-10671-2-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Atish Patra <atish.patra@oracle.com>
Date: Thu, 15 Sep 2016 14:54:40 -0600

> If kernel boot parameter nr_cpus is set, it should define the number
> of CPUs that can ever be available in the system i.e.
> cpu_possible_mask. setup_nr_cpu_ids() overrides the nr_cpu_ids based
> on the cpu_possible_mask during kernel initialization. If
> cpu_possible_mask is not set based on the nr_cpus value, earlier part
> of the kernel would be initialized using nr_cpus value leading to a
> kernel crash.
> 
> Set cpu_possible_mask based on nr_cpus value. Thus setup_nr_cpu_ids()
> becomes redundant and does not corrupt nr_cpu_ids value.
> 
> Signed-off-by: Atish Patra <atish.patra@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>

Applied.
