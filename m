From: David Miller <davem@davemloft.net>
Date: Mon, 22 Jan 2018 16:35:02 +0000
Subject: Re: [PATCH v2 0/2] Driver for Oracle Data Analytics Accelerator
Message-Id: <20180122.113502.930388214324368727.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue,  5 Dec 2017 19:40:41 -0700

> v2:
>   Revised example code and updated documentation
>   New version of Hypervisor API specification
> 
> Recent Oracle Sparc processors (M7 and M8) have a coprocessor which
> lives on the cpu chip. The coprocessor is called DAX (Data Analytics
> Accelerator), and is controlled via sun4v hypercalls. The programmatic
> interface to the coprocessor is somewhat unorthodox, and all commands
> and parameters are documented in detail in dax-hv-api.txt. The driver
> API is described in oracle-dax.txt, which has been expanded with new
> example code along with detailed explanations to demonstrate how user
> and kernel code can use the capabilities of DAX.  Those who wish to
> use the coprocessor in the kernel will need to construct their own
> command blocks to submit, as no higher level services are provided.
> Note that it is expected that general use of the coprocessor will go
> through the companion userspace library, which has been published
> under UPL at:
> 	  https://oss.oracle.com/git/gitweb.cgi?p=libdax.git
> This library is a comprehensive collection of higher level functions
> along with tests, documentation, and code examples. The format of the
> command control blocks is described in this library as well. Though
> the primary purpose of the coprocessor is to accelerate data analytics
> operations, it may be used for any suitable purpose.
> 
> The machine descriptor identifies the device as "dax", and all
> internal documentation refers to it as "dax". But since the term "dax"
> already has other meanings and uses in Linux, we call this driver
> "oradax".

Series applied to sparc-next, thanks for doing all of this hard work.
