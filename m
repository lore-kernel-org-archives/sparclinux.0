From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 10 Nov 2004 22:48:44 +0000
Subject: Re: Ross Hypersparc build question
Message-Id: <20041110224844.GB16994@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20041110223916.GA498@verizon.net>
In-Reply-To: <20041110223916.GA498@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Nov 10, 2004 at 05:39:17PM -0500, Stan Benoit wrote:

> How do I insure that ross.h or any other ross code is used during a 
> kernel build?  Will the -mcpu=hypersparc switch do this..? 

It's automatic, you don't need to do anything special.  Default
kernels support various chips, including those.

> One other question: Does gcc always pop in nop for filling delay 
> slots?

No, it tries to put useful instructions there.

-- 
Keith M Wesolowski
"Site launched. Many things not yet working." --Hector Urtubia
