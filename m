From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 23 Feb 2018 22:11:01 +0000
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data Integrity)
Message-Id: <7223b9b5-c05a-8ade-beaa-e7e82cc8ea01@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <201802231005.WSf8KcHd%fengguang.wu@intel.com>
 <490b8c3b-fc62-b6e7-af28-7c1257e953ce@oracle.com>
 <20180223.135716.511559214062584207.davem@davemloft.net>
In-Reply-To: <20180223.135716.511559214062584207.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, corbet@lwn.net, steven.sistare@oracle.com, pasha.tatashin@oracle.com, mike.kravetz@oracle.com, rob.gardner@oracle.com, mingo@kernel.org, nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com, vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz, punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org, minchan@kernel.org, imbrenda@linux.vnet.ibm.com, aarcange@redhat.com, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com, linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com, jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, khalid@gonehiking.org

On 02/23/2018 11:57 AM, David Miller wrote:
> From: Khalid Aziz <khalid.aziz@oracle.com>
> Date: Fri, 23 Feb 2018 11:51:25 -0700
> 
>> On 02/22/2018 07:50 PM, kbuild test robot wrote:
>>> Hi Khalid,
>>> I love your patch! Yet something to improve:
>>> [auto build test ERROR on sparc-next/master]
>>> [also build test ERROR on v4.16-rc2]
>>> [cannot apply to next-20180222]
>>> [if your patch is applied to the wrong git tree, please drop us a note
>>> to help improve the system]
>>> url:
>>> https://github.com/0day-ci/linux/commits/Khalid-Aziz/Application-Data-Integrity-feature-introduced-by-SPARC-M7/20180223-071725
>>> base:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git
>>> master
>>> config: sparc64-allyesconfig (attached as .config)
>>> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>           wget
>>>           https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>>           -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # save the attached .config to linux build tree
>>>           make.cross ARCH=sparc64
>>> All error/warnings (new ones prefixed by >>):
>>
>> Hi Dave,
>>
>> Including linux/sched.h in arch/sparc/include/asm/mmu_context.h should
>> eliminate these build warnings. My gcc version 6.2.1 does not report
>> these errors. Build bot is using 7.2.0.
>>
>> I can add a patch 12 to add the include, revise patch 10 or you can
>> add the include in your tree. Let me know how you would prefer to
>> resolve this.
> 
> You need to update patch #10 so that your patch series is fully
> bisectable.

Hi Dave,

That sounds like the right thing to do. I am updating patch 10 and will 
send out v13 for patch 10/11. Rest of the series is unchanged but I can 
send the whole series if you prefer that.

Thanks,
Khalid
