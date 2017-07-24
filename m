From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Mon, 24 Jul 2017 13:33:29 +0000
Subject: Re: [PATCH v2 3/3] sparc64: Increase max_phys_bits to 51 for M8.
Message-Id: <c7ed28ae-7ea0-2b2d-88a8-e08da66ad094@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500876859-8398-3-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500876859-8398-3-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Allen,

On 7/24/2017 1:14 AM, Allen Pais wrote:
 > From: Vijay Kumar <vijay.ac.kumar@oracle.com>
 >
 > On M8 chips, use a max_phys_bits value of 51 and also fix the VA hole.
 >
 > Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
 > Reviewed-by: Bob Picco <bob.picco@oracle.com>
 > Signed-off-by: Allen Pais <allen.pais@oracle.com>
 > ---

This patch needs to go with sparc-5-Level-paging  patch. I am still 
working on adding boot time selection option, so please ignore this 
patch for now. I will post this patch separately with sparc-5-level patch.

Thanks,
Vijay
