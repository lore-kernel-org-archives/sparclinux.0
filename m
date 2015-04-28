From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 28 Apr 2015 02:46:15 +0000
Subject: Re: [PATCH RFC 1/1] sparc64: pci slots information is not populated in sysfs
Message-Id: <CAGRGNgUOs3p3FLRgY_gpuXK5iwru9+7j-WukG58E_rkX7VgSDQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1430172435-231374-1-git-send-email-eric.snowberg@oracle.com>
In-Reply-To: <1430172435-231374-1-git-send-email-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hi Eric,

(Quoting screwed up due to Eric replying with a HTML message which was
probably dropped by vger.)

On Tue, Apr 28, 2015 at 12:36 PM, Eric Snowberg
<eric.snowberg@oracle.com> wrote:
>
> On Apr 27, 2015, at 5:42 PM, Julian Calaby <julian.calaby@gmail.com> wrote:
>
> Hi Eric,
>
> On Tue, Apr 28, 2015 at 8:07 AM, Eric Snowberg <eric.snowberg@oracle.com>
> wrote:
>
> Add PCI slot numbers within sysfs for sun4v hardware. Larger
> sun4v systems contain nested PCI bridges and slots further
> down on these bridges were not being populated within sysfs.
> Also add AHCI style PCI slot numbers within sysfs for sun4v
>
>
> You mean ACPI, right?
>
>
> You are correct, I’ll update the comment.
>
>
> hardware since the OF 'slot-names' information is not available
> on all sun4v platforms.
>
>
> That doesn't seem to match the actual code, which appears to skip to
> the next device if it can't find the "physical-slot#" OF property: I
> don't see how the code can fall back to any other method of
> determining the slot number.
>
>
> Correct, with this patch on sun4v systems only the ‘physical-slot#’ field is
> used.  All other system types use the old method.  With the current code, I
> could not find a single sun4v system where slot numbers would ever show up.
> I tried this out on a T2, T5, and T7.  All with latest released OBP
> firmware. Either the ‘slot-names’ field was buried or it was not present.
> Since I could not find a sun4v system where it worked, I did not create a
> fall back method.

Ah, I thought you meant that not all sun4v systems had the
"physical-slot#" property, hence my confusion when your code assumed
that they all did.

> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> arch/sparc/kernel/pci.c |   37 +++++++++++++++++++++++++++++++++++++
> 1 files changed, 37 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index 6f7251f..3a5c402 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -1002,6 +1002,38 @@ static int __init pcibios_init(void)
> subsys_initcall(pcibios_init);
>
> #ifdef CONFIG_SYSFS
> +
> +#define SLOT_NAME_SIZE  11  /* Max decimal digits + null in u32 */
> +
> +static void pci_sun4v_bus_slot_names(struct pci_bus *pbus)
> +{
> +       struct pci_dev *pdev;
> +       struct pci_bus *bus;
> +
> +       list_for_each_entry(pdev, &pbus->devices, bus_list) {
> +               char name[SLOT_NAME_SIZE];
> +               struct pci_slot *pci_slot;
> +               const u32 *slot_num;
> +               int len;
> +
> +               slot_num = of_get_property(pdev->dev.of_node,
> +                                          "physical-slot#", &len);
> +
> +               if (slot_num = NULL || len != 4)
> +                       continue;
> +
> +               snprintf(name, sizeof(name), "%u", slot_num[0]);
> +               pci_slot = pci_create_slot(pbus, slot_num[0], name, NULL);
> +
> +               if (IS_ERR(pci_slot))
> +                       pr_err("PCI: pci_create_slot returned %ld.\n",
> +                              PTR_ERR(pci_slot));
> +       }
> +
> +       list_for_each_entry(bus, &pbus->children, node)
> +               pci_sun4v_bus_slot_names(bus);
> +}
> +
> static void pci_bus_slot_names(struct device_node *node, struct pci_bus
> *bus)
> {
>        const struct pci_slot_names {
> @@ -1054,6 +1086,11 @@ static int __init of_pci_slot_init(void)
>        while ((pbus = pci_find_next_bus(pbus)) != NULL) {
>                struct device_node *node;
>
> +               if (tlb_type = hypervisor) {
> +                       pci_sun4v_bus_slot_names(pbus);
> +                       continue;
>
>
> Are you sure that unconditionally continuing to the next bus is the
> right thing to do here?
>
>
> I believe so, I am using the same recursive pattern in
> pci_sun4v_bus_slot_names found throughout this file.
>
>
> Where is the slot name set if we can't find the "physical-slot#"
> property for a device?
>
>
> My understanding is if a device does not have a ‘physical-slot#’ then the
> device is not in a physical PCI slot, so it should not have a slot name.

Ok, that makes sense.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
