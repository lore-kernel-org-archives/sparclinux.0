From: David Miller <davem@davemloft.net>
Date: Sat, 13 Sep 2008 01:01:36 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <20080912.180136.266649034.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Elad Lahav <elahav@uwaterloo.ca>
Date: Fri, 12 Sep 2008 20:47:24 -0400

> > The kernel treats core_id=0 as special, therefore we start the
> > indexes there at "1".
> > The kernel treats proc_id=-1 as special, therefore we start those
> > indexes at "0".
>
> My problem was not with the indexing, but rather with the meaning of
> proc_id. It's neither the physical processor ID, nor the virtual
> processor ID. It's just a one-to-one mapping of the core ID. As the
> virtual processor ID is the same as the kernel's CPU ID, I think
> that proc_id should hold the physical processor ID. If not, than
> this information should be kept in some other field of cpu_data.

For a cpu such as Niagara T1, the proc_id and core_id will represent
the same thing.  Niagara T1 comes only in single socket variants.

For Niagara T2, which can be multisocket, core_id and proc_id can be different.

Look at how this information is obtained from the machine description in
arch/sparc64/kernel/mdesc.c, and then look at how it is used to build the
sibling and core cpu maps, which are used to build the scheduling domain
datastructures in kernel/sched.c

If afterwards you think there is still some problem, thene please
describe a discrete issue you thing arises because of how these
values are set.
