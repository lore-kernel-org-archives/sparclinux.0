From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 17 Nov 2017 02:14:37 +0000
Subject: Re: [PATCH RESEND v10 00/10] Application Data Integrity feature introduced by SPARC M7
Message-Id: <3D32E16F-281B-464B-8F6D-D6A8FE62FAB2@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1510768775.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1510768775.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: David Miller <davem@davemloft.net>, dave.hansen@linux.intel.com, akpm@linux-foundation.org, 0x7f454c46@gmail.com, aarcange@redhat.com, ak@linux.intel.com, Allen Pais <allen.pais@oracle.com>, aneesh.kumar@linux.vnet.ibm.com, arnd@arndb.de, Atish Patra <atish.patra@oracle.com>, benh@kernel.crashing.org, Bob Picco <bob.picco@oracle.com>, bsingharora@gmail.com, chris.hyser@oracle.com, cmetcalf@mellanox.com, corbet@lwn.net, dan.carpenter@oracle.com, dave.jiang@intel.com, dja@axtens.net, Eric Saint Etienne <eric.saint.etienne@oracle.com>, geert@linux-m68k.org, hannes@cmpxchg.org, heiko.carstens@de.ibm.com, hpa@zytor.com, hughd@google.com, imbrenda@linux.vnet.ibm.com, jack@suse.cz, jmarchan@redhat.com, jroedel@suse.de, Khalid Aziz <khalid@gonehiking.org>, kirill.shutemov@linux.intel.com


> On Nov 16, 2017, at 6:38 AM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
> Changelog v10:
> 
> 	- Patch 1/10: Updated si_codes definitions for SEGV to match 4.14
> 	- Patch 2/10: No changes
> 	- Patch 3/10: Updated copyright
> 	- Patch 4/10: No changes
> 	- Patch 5/10: No changes
> 	- Patch 6/10: Updated copyright
> 	- Patch 7/10: No changes
> 	- Patch 8/10: No changes
> 	- Patch 9/10: No changes
> 	- Patch 10/10: Added code to return from kernel path to set
> 	  PSTATE.mcde if kernel continues execution in another thread
> 	  (Suggested by Anthony)

Looks good, Khalid.  Thanks for making the changes.

For the entire series:

Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
