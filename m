From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 12:44:32 +0000
Subject: Re: [PATCH] sparc64: use COMMAND_LINE_SIZE for boot string
Message-Id: <5433E030.8090101@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5432BE03.10405@oracle.com>
In-Reply-To: <5432BE03.10405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

uOn 10/06/2014 11:23 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Mon, 06 Oct 2014 11:06:27 -0500
> 
>> sparc64 defines COMMAND_LINE_SIZE to be 2048, but the boot string is
>> hard-coded to be 256 bytes long.
>>
>> based on a patch by Bob Picco
>>
>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> I think we might be limited by the size of barg_out[] in the SILO
> bootloader, which is 1024 bytes.
> 
> SILO massages the command line into barg_out[] then does:
> 
> 		if (architecture = sun4u)
> 		    kernel_params = (char *)((hdrs->bootstr_info_ptr_low - 0x400000) + 
> 				(image_base - 0x4000));
>  ...
> 	if (kernel_params) {
>     	    extern char barg_out[];
>     	    int len = *(unsigned int *)kernel_params;
> 
>     	    strncpy (kernel_params + 8, barg_out, len);
>     	    kernel_params [8 + len - 1] = 0;
>     	    *(unsigned int *)(kernel_params + 4) = 1;
> 	}
> 
> So it blindly copies however many bytes you tell it to in that
> bootstr_info area :-/
> 
> So I'm happy to apply a patch that increases the size to 1024,
> whilst adding a comment explaining the SILO limitation.

That makes sense. 1024 is much better than 256. I'll send a new patch.

Thanks,
Dave
