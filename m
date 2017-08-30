From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 30 Aug 2017 01:47:23 +0000
Subject: Re: RFC: Driver for Oracle Data Analytics Accelerator
Message-Id: <536ec95a-6cc8-3329-d208-ee993788b645@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 08/29/2017 07:07 PM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Tue, 29 Aug 2017 17:36:01 -0600
>
>> Any and all feedback welcome and appreciated.
> So basically binary blobs will be passed into this driver, and there
> will be no verification or documentation of the various DAX
> operations, their parameters, what operation they perform, how they
> work, and their how their references to the user's buffers operate?
>
> Right?
>

No, that is not at all how it works. Full documentation of the command 
interface will be provided in the library. The driver is just a 
transport to connect user space with the hypervisor calls.

Rob

