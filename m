From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 06 Jan 2015 23:34:21 +0000
Subject: Re: [PATCH V2] sparc64: fatal trap should stop all cpus
Message-Id: <54AC70FD.1020101@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <54AB1B83.6070800@oracle.com>
In-Reply-To: <54AB1B83.6070800@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/06/2015 04:23 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Mon, 05 Jan 2015 17:17:23 -0600
> 
>> The below patch works with the hypervisor. I'm not sure if the calls
>> to set_cpu_online are really needed, but I left them in for now.
> 
> I don't see any other implementation of smp_send_stop() doing this.
> 
> I'd rather you leave it out.

Okay. I'm fine with that.

> Please also submit new versions of patches properly, as fresh
> list postings.
> 
> Otherwise I have to edit out the commit message and that's more
> work for me.

No problem
