From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 30 Mar 2015 21:38:25 +0000
Subject: Re: [PATCH v7 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <20150330213825.GN26127@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
 <b9dbeef3a3ae463a5198b6d34eb446ae50966a66.1427295804.git.sowmini.varadhan@oracle.com>
 <1427685844.20500.66.camel@kernel.crashing.org>
 <20150330103824.GA26127@oracle.com>
 <1427712943.20500.77.camel@kernel.crashing.org>
 <20150330130116.GE26127@oracle.com>
 <20150330211525.GM26127@oracle.com>
 <1427750937.20500.99.camel@kernel.crashing.org>
In-Reply-To: <1427750937.20500.99.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On (03/31/15 08:28), Benjamin Herrenschmidt wrote:
> 
> Provided that the IB test doesn't come up with a significant difference,
> I definitely vote for the simpler version of doing a normal spin_lock.

sounds good. let me wait for the confirmation from IB,
and I'll send out patchv8 soon after. 

FWIW, I'm ok with all the other comments- thanks for the feedback.

--Sowmini

