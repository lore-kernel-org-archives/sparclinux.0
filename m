From: David Miller <davem@davemloft.net>
Date: Thu, 01 Feb 2018 20:39:03 +0000
Subject: Re: [PATCH v11 03/10] sparc64: Add support for ADI register fields, ASIs and traps
Message-Id: <20180201.153903.1719756519690647679.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
	<e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
	<1517517122.7489.47.camel@perches.com>
In-Reply-To: <1517517122.7489.47.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: khalid.aziz@oracle.com, dave.hansen@linux.intel.com, mhocko@suse.com, mingo@kernel.org, gregkh@linuxfoundation.org, glx@linutronix.de, kstewart@linuxfoundation.org, vijay.ac.kumar@oracle.com, kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com, tom.hromatka@oracle.com, allen.pais@oracle.com, rob.gardner@oracle.com, david.j.aldridge@oracle.com, babu.moger@oracle.com, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, vegard.nossum@oracle.com, pombredanne@nexb.com, jane.chu@oracle.com, anthony.yznaga@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, khalid@gonehiking.org

From: Joe Perches <joe@perches.com>
Date: Thu, 01 Feb 2018 12:32:02 -0800

>> diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
> []
>> @@ -219,6 +219,16 @@
>>  	nop;						\
>>  	nop;
>>  
>> +#define SUN4V_MCD_PRECISE				\
>> +	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
>> +	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
>> +	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
>> +	ba,pt	%xcc, etrap;				\
>> +	 rd	%pc, %g7;				\
>> +	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
>> +	 nop;						\
>> +	nop;
> 
> and here and elsewhere.

Joe, this is intentional in Sparc assembler.

Branches on sparc have delay slots, and this is annotated by indenting
the delay slot instruction one space more than the branch preceeding
it.

Please make more constructive review comments than whitespace as these
patches have been under review for more than half a year.

Thank you very much.
