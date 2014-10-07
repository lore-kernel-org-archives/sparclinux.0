From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 19:29:25 +0000
Subject: Re: [PATCH] sparc64: Increase size of boot string to 1024 bytes
Message-Id: <54343F15.2040903@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5433E6C5.9060304@oracle.com>
In-Reply-To: <5433E6C5.9060304@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 10/07/2014 01:57 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Tue, 07 Oct 2014 08:12:37 -0500
> 
>> This is the longest boot string that silo supports.
>>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> Ok, given how the rest of this thread went, the comment needs to
> be adjusted to match reality which is something like:
> 
> /* We limit BARG_LEN to 1024 because this is the size of the
>  * 'barg_out' command line buffer in the SILO bootloader.  And
>  * it trusts bootstr_len over that buffer's size.
>  */
> 
> Right?

I'd leave off the last sentence:

/* We limit BARG_LEN to 1024 because this is the size of the
 * 'barg_out' command line buffer in the SILO bootloader.
 */
