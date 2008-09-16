From: Elad Lahav <elahav@uwaterloo.ca>
Date: Tue, 16 Sep 2008 18:47:39 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <48CFFF4B.7090607@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The interrupts will arrive at a certain processor, will wake up
> the process, and if this happens enough the process will migrate
> to that cpu.
True, except that on the Niagara this may not be the desired configuration, as it would
result in both the process and the interrupt handling executing on the same strand.
I've just tested it, and this seems to be the case. I don't know how the scheduler is
tuned for inter-strand load-balancing, but it seems like having the process on a different
strand on the same core would be preferable.

>>> Niagara T1 is a single "package", with 8 "cores".
>> Exactly my point. So why isn't there a single physical package ID for all CPUs under /sys/devices/system/cpu/cpuX/topology/physical_package_id ?
> 
> I misspoke here, this is not how I use the topology.
If proc_id is used by the scheduler and is supposed to indicate the internal core
arrangement, then cpu_data should have an extra phys_proc_id field, similar to other
architectures (which would then be exported via physical_package_id).

Elad

