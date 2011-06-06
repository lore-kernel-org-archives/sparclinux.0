From: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
Date: Mon, 06 Jun 2011 23:06:13 +0000
Subject: Re: mmap operation not working as expected on sparc linux
Message-Id: <4DED5D65.70007@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DE5F5B9.4020601@redhat.com>
In-Reply-To: <4DE5F5B9.4020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 02.06.2011 17:47, william felipe_welter wrote:
 > Some ideas ? What can be the reason of this behavior ?

Any fixed and shared mmap() mapping address must be aligned to SHMLBA as 
mentioned by Dave. I guess the first mmap() succeeds because these 
restrictions do not apply to private mappings. The second mmap() wants a 
shared memory mapping but the address returned by the first one is only 
page-aligned and not aligned to SHMLBA. This is why the second one fails.

See the comment in
http://lxr.linux.no/#linux+v2.6.39/arch/sparc/kernel/sys_sparc_64.c#L124



On 02.06.2011 23:53, Steven Dake wrote:
> 2.
> further creations of circular memory maps caused all sorts of problems
> on sparc but not on x86_64.
>
> This resulted in later circular memory maps we wanted to create having
> to be 4MB in size to work properly.  I can't explain why.
>
> I changed the mmap operation in 1 to do the following:
>          addr = mmap (NULL, bytes, PROT_READ | PROT_WRITE,
>                  MAP_SHARED, fd, 0);
>
> This allows our software to function properly.

This may work only by accident. You're requesting a new mapping for 
which the kernel may choose a virtual address. There is no guarantee 
that there is enough space after this address to also map the buffer for 
the second time. Therefore, the third mmap() call might fail. If it does 
not fail, you're just lucky.

As far as I can see, the first mmap() is only there in order to find a 
large enough region in the virtual address space that the buffer can be 
mapped twice - one after the other. There is no point in mapping it the 
first time successfully and then finding out that there is already 
something else mapped right behind it.

In order to make this circular buffer work, you need the two mappings 
being consecutive. Furthermore, (due to architectural restrictions) any 
two successful mmap() mappings are at least SHMLBA bytes away from each 
other and are also aligned to this size. Therefore, your buffer must be 
at least SHMLBA bytes large to avoid a gap and both mappings must be 
aligned to SHMLBA bytes.

Unfortunatelly, you cannot specify the alignment for mmap(). You either 
choose an address by yourself (which one?) or you make the kernel decide 
for you. Therefore, the difficulty is to find an address suitable for 
the first of the three mmap() calls.

You could try the following:
At first let the kernel choose an address for the first mmap(). If it is 
successful but the alignment is not right, you can take this address and 
align it properly by hand in order to repeat the first mmap() with this 
aligned address. I guess, in most cases this should succeed. If it does 
not, you can repeat the first mmap() request with three times the buffer 
size. If it is successful and the alignment is right, then you're done. 
If not, align it by hand and try again.

Something like this:


#include <asm/shmparam.h>
#define ALIGNUP(p, q)	\
	((void *)(((unsigned long)(p) + (q) - 1) & ~((q) - 1)))
#define ALIGN_TEST(p, q)	\
	((unsigned long)(p) & ~((q) - 1)) = (unsigned long)(p))

/* forward declaration */
void ring_buffer_free (struct ring_buffer *buffer);

void
ring_buffer_create (struct ring_buffer *buffer, unsigned long order)
{
...
   int req_size;
...
   buffer->address = mmap (NULL, buffer->count_bytes << 1, PROT_NONE,
                           MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

   if (buffer->address = MAP_FAILED)
     report_exceptional_condition ();

/* my proposal goes here */
#if __ARCH_FORCE_SHMLBA
   if(buffer->count_bytes < SHMLBA) /* ... then this cannot work */
      report_exceptional_condition ();

   req_size = buffer->count_bytes << 1;
   while(1) {
     if (buffer->address = MAP_FAILED)
       report_exceptional_condition ();
     if (ALIGN_TEST(buffer->address, SHMLBA)) {
       break;
     } else {
       /* try again this addr with manual alignment */
       void *aligned_addr = ALIGNUP(buffer->address, SHMLBA);
       if (buffer->address != MAP_FAILED)
         ring_buffer_free(buffer);

       buffer->address = mmap (aligned_addr, req_size, PROT_NONE,
                               MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
       if (buffer->address != MAP_FAILED)
         break;

       if(req_size = buffer->count_bytes << 1) {
         /* failed; try again in larger region */
         req_size = 3 * buffer->count_bytes;
         buffer->address = mmap (NULL, req_size, PROT_NONE,
                                 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
       } else {
         report_exceptional_condition ();
       }
     }
   }
#endif
/* 2nd and third mmap() go here; they should succeed */


This is not tested, as I don't have any SPARC hardware near me at the 
moment. But I guess this should work also for buffer sizes much smaller 
than 4 MiB.


On 02.06.2011 23:27, David Miller wrote:
 > Also, please prepare a test case for me, I want to fix this.

I don't think there is anything to fix inside of the kernel. People just 
need to pay attention to the SHMLBA alignment when they specify 
MAP_FIXED | MAP_SHARED.
