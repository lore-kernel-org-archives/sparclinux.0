From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 21 Sep 2017 22:18:44 +0000
Subject: [PATCH 2/2] sparc64: Oracle DAX driver
Message-Id: <1506032324-14146-3-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

DAX is a coprocessor which resides on the SPARC M7 (DAX1) and M8
(DAX2) processor chips, and has direct access to the CPU's L3 caches
as well as physical memory. It can perform several operations on data
streams with various input and output formats.  This driver provides a
transport mechanism and has limited knowledge of the various opcodes
and data formats. A user space library provides high level services
and translates these into low level commands which are then passed
into the driver and subsequently the hypervisor and the coprocessor.
The library is the recommended way for applications to use the
coprocessor, and the driver interface is not intended for general use.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
Signed-off-by: Sanath Kumar <sanath.s.kumar@oracle.com>
---
 Documentation/sparc/oradax/dax-hv-api.txt    | 1405 ++++++++++++++++++++++++++
 Documentation/sparc/oradax/dax1_ccb.h        |  591 +++++++++++
 Documentation/sparc/oradax/extract_example.c |  219 ++++
 Documentation/sparc/oradax/oracle_dax.txt    |  249 +++++
 Documentation/sparc/oradax/scan_example.c    |  214 ++++
 arch/sparc/include/uapi/asm/oradax.h         |   91 ++
 drivers/sbus/char/Kconfig                    |    8 +
 drivers/sbus/char/Makefile                   |    1 +
 drivers/sbus/char/oradax.c                   | 1005 ++++++++++++++++++
 9 files changed, 3783 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/sparc/oradax/dax-hv-api.txt
 create mode 100644 Documentation/sparc/oradax/dax1_ccb.h
 create mode 100644 Documentation/sparc/oradax/extract_example.c
 create mode 100644 Documentation/sparc/oradax/oracle_dax.txt
 create mode 100644 Documentation/sparc/oradax/scan_example.c
 create mode 100644 arch/sparc/include/uapi/asm/oradax.h
 create mode 100644 drivers/sbus/char/oradax.c

diff --git a/Documentation/sparc/oradax/dax-hv-api.txt b/Documentation/sparc/oradax/dax-hv-api.txt
new file mode 100644
index 0000000..90d21d6
--- /dev/null
+++ b/Documentation/sparc/oradax/dax-hv-api.txt
@@ -0,0 +1,1405 @@
+Excerpt from UltraSPARC Virtual Machine Specification
+Extracted via "pdftotext -f 546 -l 571 -layout sun4v-3.0.20.pdf"
+Compiled from version 3.0.20
+Publication date 2017-04-05 18:15
+Copyright © 2008, 2015 Oracle and/or its affiliates. All rights reserved.
+
+
+Chapter 36. Coprocessor services
+        The following APIs provide access via the Hypervisor to hardware assisted data processing functionality.
+        These APIs may only be provided by certain platforms, and may not be available to all virtual machines
+        even on supported platforms. Restrictions on the use of these APIs may be imposed in order to support
+        live-migration and other system management activities.
+
+36.1. Data Analytics Accelerator
+        The Data Analytics Accelerator (DAX) functionality is a collection of hardware coprocessors that provide
+        high speed processoring of database-centric operations. The coprocessors may support one or more of
+        the following data query operations: search, extraction, compression, decompression, and translation. The
+        functionality offered may vary by virtual machine implementation.
+
+        The DAX is a virtual device to sun4v guests, with supported data operations indicated by the virtual de-
+        vice compatibilty property. Functionality is accessed through the submission of Command Control Blocks
+        (CCBs) via the ccb_submit API function. The operations are processed asynchronously, with the status of
+        the submitted operations reported through a Completion Area linked to each CCB. Each CCB has a sep-
+        arate Completion Area and, unless execution order is specifically restricted through the use of serial-con-
+        ditional flags, the execution order of submitted CCBs is arbitrary. Likewise, the time to completion for
+        a given CCB is never guaranteed.
+
+        Guest software may implement a software timeout on CCB operations, and if the timeout is exceeded, the
+        operation may be cancelled or killed via the ccb_kill API function. It is recommended for guest software
+        to implement a software timeout to account for certain RAS errors which may result in lost CCBs. It is
+        recommended such implementation use the ccb_info API function to check the status of a CCB prior to
+        killing it in order to determine if the CCB is still in queue, or may have been lost due to a RAS error.
+
+        There is no fixed limit on the number of outstanding CCBs guest software may have queued in the virtual
+        machine, however, internal resource limitations within the virtual machine can cause CCB submissions
+        to be temporarily rejected with EWOULDBLOCK. In such cases, guests should continue to attempt sub-
+        missions until they succeed; waiting for an outstanding CCB to complete is not necessary, and would not
+        be a guarantee that a future submission would succeed.
+
+        The availablility of DAX coprocessor command service is indicated by the presence of the DAX virtual
+        device node in the guest MD (Section 8.24.17, “Database Analytics Accelerators (DAX) virtual-device
+        node”).
+
+36.1.1. DAX Compatibility Property
+        The query functionality may vary based on the compatibility property of the virtual device:
+
+36.1.1.1. "ORCL,sun4v-dax" Device Compatibility
+        Available CCB commands:
+
+        • No-op/Sync
+
+        • Extract
+
+        • Scan Value
+
+        • Inverted Scan Value
+
+        • Scan Range
+
+        • Inverted Scan Range
+
+
+                                                     509
+                                             Coprocessor services
+
+
+        • Translate
+
+        • Inverted Translate
+
+        • Select
+        See Section 36.2.1, “Query CCB Command Formats” for the corresponding CCB input and output formats.
+
+        Only version 0 CCBs are available.
+
+36.1.1.2. "ORCL,sun4v-dax-fc" Device Compatibility
+        "ORCL,sun4v-dax-fc" is compatible with the "ORCL,sun4v-dax" interface, and includes additional CCB
+        bit fields and controls.
+
+36.1.1.3. "ORCL,sun4v-dax2" Device Compatibility
+        Available CCB commands:
+        • No-op/Sync
+
+        • Extract
+
+        • Scan Value
+
+        • Inverted Scan Value
+
+        • Scan Range
+
+        • Inverted Scan Range
+
+        • Translate
+
+        • Inverted Translate
+
+        • Select
+
+        See Section 36.2.1, “Query CCB Command Formats” for the corresponding CCB input and output formats.
+
+        Version 0 and 1 CCBs are available. Only version 0 CCBs may use Huffman encoded data, whereas only
+        version 1 CCBs may use OZIP.
+
+36.1.2. DAX Virtual Device Interrupts
+        The DAX virtual device has multiple interrupts associated with it which may be used by the guest if
+        desired. The number of device interrupts available to the guest is indicated in the virtual device node of the
+        guest MD (Section 8.24.17, “Database Analytics Accelerators (DAX) virtual-device node”). If the device
+        node indicates N interrupts available, the guest may use any value from 0 to N - 1 (inclusive) in a CCB
+        interrupt number field. Using values outside this range will result in the CCB being rejected for an invalid
+        field value.
+
+        The interrupts may be bound and managed using the standard sun4v device interrupts API (Chapter 16,
+        Device interrupt services). Sysino interrupts are not available for DAX devices.
+
+36.2. Coprocessor Control Block (CCB)
+        CCBs are either 64 or 128 bytes long, depending on the operation type. The exact contents of the CCB
+        are command specific, but all CCBs contain at least one memory buffer address. All memory locations
+        referenced by a CCB must be pinned in memory until the CCB either completes execution or is killed via
+        the ccb_kill API call. Changes in virtual address mappings occurring after CCB submission are not guar-
+        anteed to be visible, and as such all virtual address updates need to be synchronized with CCB execution.
+
+
+                                                      510
+                                    Coprocessor services
+
+
+All CCBs begin with a common 32-bit header.
+
+Table 36.1. CCB Header Format
+
+Bits          Field Description
+[31:28]       CCB version. For API version 2.0: set to 1 if CCB uses OZIP encoding; set to 0 if the CCB
+              uses Huffman encoding; otherwise either 0 or 1. For API version 1.0: always set to 0.
+[27]          When API version 2.0 is negotiated, this is the Pipeline Flag. It is reserved in API version
+              1.0
+[26]          Long CCB flag
+[25]          Conditional synchronization flag
+[24]          Serial synchronization flag
+[23:16]       CCB operation code:
+              0x00         No Operation (No-op) or Sync
+              0x01         Extract
+              0x02         Scan Value
+              0x12         Inverted Scan Value
+              0x03         Scan Range
+              0x13         Inverted Scan Range
+              0x04         Translate
+              0x14         Inverted Translate
+              0x05         Select
+[15:13]       Reserved
+[12:11]       Table address type
+              0b'00        No address
+              0b'01        Alternate context virtual address
+              0b'10        Real address
+              0b'11        Primary context virtual address
+[10:8]        Output/Destination address type
+              0b'000       No address
+              0b'001       Alternate context virtual address
+              0b'010       Real address
+              0b'011       Primary context virtual address
+              0b'100       Reserved
+              0b'101       Reserved
+              0b'110       Reserved
+              0b'111       Reserved
+[7:5]         Secondary source address type
+              0b'000       No address
+              0b'001       Alternate context virtual address
+              0b'010       Real address
+
+
+                                            511
+                                    Coprocessor services
+
+
+Bits           Field Description
+                0b'011       Primary context virtual address
+                0b'100       Reserved
+                0b'101       Reserved
+                0b'110       Reserved
+                0b'111       Reserved
+[4:2]          Primary source address type
+                0b'000       No address
+                0b'001       Alternate context virtual address
+                0b'010       Real address
+                0b'011       Primary context virtual address
+                0b'100       Reserved
+                0b'101       Reserved
+                0b'110       Reserved
+                0b'111       Reserved
+[1:0]          Completion area address type
+                0b'00        No address
+                0b'01        Alternate context virtual address
+                0b'10        Real address
+                0b'11        Primary context virtual address
+
+The Long CCB flag indicates whether the submitted CCB is 64 or 128 bytes long; value is 0 for 64 bytes
+and 1 for 128 bytes.
+
+The Serial and Conditional flags allow simple relative ordering between CCBs. Any CCB with the Serial
+flag set will execute sequentially relative to any previous CCB that is also marked as Serial in the same
+CCB submission. CCBs without the Serial flag set execute independently, even if they are between CCBs
+with the Serial flag set. CCBs marked solely with the Serial flag will execute upon the completion of the
+previous Serial CCB, regardless of the completion status of that CCB. The Conditional flag allows CCBs
+to conditionally execute based on the successful execution of the closest CCB marked with the Serial flag.
+A CCB may only be conditional on exactly one CCB, however, a CCB may be marked both Conditional
+and Serial to allow execution chaining. The flags do NOT allow fan-out chaining, where multiple CCBs
+execute in parallel based on the completion of another CCB.
+
+The Pipeline flag is an optimization that directs the output of one CCB (the "source" CCB) directly to
+the input of the next CCB (the "target" CCB). The target CCB thus does not need to read the input from
+memory. The Pipeline flag is advisory and may be dropped.
+
+Both the Pipeline and Serial bits must be set in the source CCB. The Conditional bit must be set in the
+target CCB. Exactly one CCB must be made conditional on the source CCB; either 0 or 2 target CCBs
+is invalid. However, Pipelines can be extended beyond two CCBs: the sequence would start with a CCB
+with both the Pipeline and Serial bits set, proceed through CCBs with the Pipeline, Serial, and Conditional
+bits set, and terminate at a CCB that has the Conditional bit set, but not the Pipeline bit.
+
+The input of the target CCB must start within 64 bytes of the output of the source CCB or the pipeline flag
+will be ignored. All CCBs in a pipeline must be submitted in the same call to ccb_submit.
+
+
+
+                                             512
+                                             Coprocessor services
+
+
+        The various address type fields indicate how the various address values used in the CCB should be in-
+        terpreted by the virtual machine. Not all of the types specified are used by every CCB format. Types
+        which are not applicable to the given CCB command should be indicated as type 0 (No address). Virtual
+        addresses used in the CCB must have translation entries present in either the TLB or a configured TSB for
+        the submitting virtual processor. Virtual addresses which cannot be translated by the virtual machine will
+        result in the CCB submission being rejected, with the causal virtual address indicated. The CCB may be
+        resubmitted after inserting the translation, or the address may be translated by guest software and resub-
+        mitted using the real address translation.
+
+36.2.1. Query CCB Command Formats
+36.2.1.1. Supported Data Formats, Elements Sizes and Offsets
+
+        Data for query commands may be encoded in multiple possible formats. The data query commands use a
+        common set of values to indicate the encoding formats of the data being processed. Some encoding formats
+        require multiple data streams for processing, requiring the specification of both primary data formats (the
+        encoded data) and secondary data streams (meta-data for the encoded data).
+
+36.2.1.1.1. Primary Input Format
+        The primary input format code is a 4-bit field when it is used. There are 10 primary input formats available.
+        The packed formats are not endian neutral. Code values not listed below are reserved.
+
+         Code       Format                              Description
+         0x0        Fixed width byte packed             Up to 16 bytes
+         0x1        Fixed width bit packed              Up to 15 bits (CCB version 0) or 23 bits (CCB version
+                                                        1); bits are read most significant bit to least significant bit
+                                                        within a byte
+         0x2        Variable width byte packed          Data stream of lengths must be provided as a secondary
+                                                        input
+         0x4        Fixed width byte packed with run Up to 16 bytes; data stream of run lengths must be provid-
+                    length encoding                  ed as a secondary input
+         0x5        Fixed width bit packed with run Up to 15 bits (CCB version 0) or 23 bits (CCB version
+                    length encoding                 1); bits are read most significant bit to least significant bit
+                                                    within a byte; data stream of run lengths must be provided
+                                                    as a secondary input
+         0x8        Fixed width byte packed with Up to 16 bytes before the encoding; compressed stream
+                    Huffman (CCB version 0) or bits are read most significant bit to least significant bit
+                    OZIP (CCB version 1) encoding within a byte; pointer to the encoding table must be pro-
+                                                  vided
+         0x9        Fixed width bit packed with Huff- Up to 15 bits (CCB version 0) or 23 bits (CCB version
+                    man (CCB version 0) or OZIP 1); compressed stream bits are read most significant bit to
+                    (CCB version 1) encoding          least significant bit within a byte; pointer to the encoding
+                                                      table must be provided
+         0xA        Variable width byte packed with Up to 16 bytes before the encoding; compressed stream
+                    Huffman (CCB version 0) or bits are read most significant bit to least significant bit
+                    OZIP (CCB version 1) encoding within a byte; data stream of lengths must be provided as
+                                                    a secondary input; pointer to the encoding table must be
+                                                    provided
+         0xC        Fixed width byte packed with Up to 16 bytes before the encoding; compressed stream
+                    run length encoding, followed by bits are read most significant bit to least significant bit
+
+
+                                                      513
+                                             Coprocessor services
+
+
+        Code        Format                        Description
+                    Huffman (CCB version 0) or within a byte; data stream of run lengths must be provided
+                    OZIP (CCB version 1) encoding as a secondary input; pointer to the encoding table must
+                                                  be provided
+        0xD         Fixed width bit packed with         Up to 15 bits (CCB version 0) or 23 bits(CCB version 1)
+                    run length encoding, followed by    before the encoding; compressed stream bits are read most
+                    Huffman (CCB version 0) or          significant bit to least significant bit within a byte; data
+                    OZIP (CCB version 1) encoding       stream of run lengths must be provided as a secondary in-
+                                                        put; pointer to the encoding table must be provided
+
+        If OZIP encoding is used, there must be no reserved bytes in the table.
+
+36.2.1.1.2. Primary Input Element Size
+        For primary input data streams with fixed size elements, the element size must be indicated in the CCB
+        command. The size is encoded as the number of bits or bytes, minus one. The valid value range for this
+        field depends on the input format selected, as listed in the table above.
+
+36.2.1.1.3. Secondary Input Format
+        For primary input data streams which require a secondary input stream, the secondary input stream is
+        always encoded in a fixed width, bit-packed format. The bits are read from most significant bit to least
+        significant bit within a byte. There are two encoding options for the secondary input stream data elements,
+        depending on whether the value of 0 is needed:
+
+        Secondary Input For- Description
+        mat Code
+        0                          Element is stored as value minus 1 (0 evalutes to 1, 1 evalutes
+                                   to 2, etc)
+        1                          Element is stored as value
+
+36.2.1.1.4. Secondary Input Element Size
+        Secondary input element size is encoded as a two bit field:
+
+        Secondary Input Size Description
+        Code
+        0x0                        1 bit
+        0x1                        2 bits
+        0x2                        4 bits
+        0x3                        8 bits
+
+36.2.1.1.5. Input Element Offsets
+        Bit-wise input data streams may have any alignment within the base addressed byte. The offset, specified
+        from most significant bit to least significant bit, is provided as a fixed 3 bit field for each input type. A
+        value of 0 indicates that the first input element begins at the most significant bit in the first byte, and a
+        value of 7 indicates it begins with the least significant bit.
+
+        This field should be zero for any byte-wise primary input data streams.
+
+
+                                                      514
+                                            Coprocessor services
+
+
+36.2.1.1.6. Output Format
+        Query commands support multiple sizes and encodings for output data streams. There are four possible
+        output encodings, and up to four supported element sizes per encoding. Not all output encodings are sup-
+        ported for every command. The format is indicated by a 4-bit field in the CCB:
+
+         Output Format Code        Description
+         0x0                       Byte aligned, 1 byte elements
+         0x1                       Byte aligned, 2 byte elements
+         0x2                       Byte aligned, 4 byte elements
+         0x3                       Byte aligned, 8 byte elements
+         0x4                       16 byte aligned, 16 byte elements
+         0x5                       Reserved
+         0x6                       Reserved
+         0x7                       Reserved
+         0x8                       Packed vector of single bit elements
+         0x9                       Reserved
+         0xA                       Reserved
+         0xB                       Reserved
+         0xC                       Reserved
+         0xD                       2 byte elements where each element is the index value of a bit,
+                                   from an bit vector, which was 1.
+         0xE                       4 byte elements where each element is the index value of a bit,
+                                   from an bit vector, which was 1.
+         0xF                       Reserved
+
+36.2.1.1.7. Application Data Integrity (ADI)
+        On platforms which support ADI, the ADI version number may be specified for each separate memory
+        access type used in the CCB command. ADI checking only occurs when reading data. When writing data,
+        the specified ADI version number overwrites any existing ADI value in memory.
+
+        An ADI version value of 0 or 0xF indicates the ADI checking is disabled for that data access, even if it is
+        enabled in memory. By setting the appropriate flag in CCB_SUBMIT (Section 36.3.1, “ccb_submit”) it is
+        also an option to disable ADI checking for all inputs accessed via virtual address for all CCBs submitted
+        during that hypercall invocation.
+
+        The ADI value is only guaranteed to be checked on the first 64 bytes of each data access. Mismatches on
+        subsequent data chunks may not be detected, so guest software should be careful to use page size checking
+        to protect against buffer overruns.
+
+36.2.1.1.8. Page size checking
+        All data accesses used in CCB commands must be bounded within a single memory page. When addresses
+        are provided using a virtual address, the page size for checking is extracted from the TTE for that virtual
+        address. When using real addresses, the guest must supply the page size in the same field as the address
+        value. The page size must be one of the sizes supported by the underlying virtual machine. Using a value
+        that is not supported may result in the CCB submission being rejected or the generation of a CCB parsing
+        error in the completion area.
+
+
+                                                     515
+                                               Coprocessor services
+
+
+36.2.1.2. Extract command
+
+        Converts an input vector in one format to an output vector in another format. All input format types are
+        supported.
+
+        The only supported output format is a padded, byte-aligned output stream, using output codes 0x0 - 0x4.
+        When the specified output element size is larger than the extracted input element size, zeros are padded to
+        the extracted input element. First, if the decompressed input size is not a whole number of bytes, 0 bits are
+        padded to the most significant bit side till the next byte boundary. Next, if the output element size is larger
+        than the byte padded input element, bytes of value 0 are added based on the Padding Direction bit in the
+        CCB. If the output element size is smaller than the byte-padded input element size, the input element is
+        truncated by dropped from the least significant byte side until the selected output size is reached.
+
+        The return value of the CCB completion area is invalid. The “number of elements processed” field in the
+        CCB completion area will be valid.
+
+        The extract CCB is a 64-byte “short format” CCB.
+
+        The extract CCB command format can be specified by the following packed C structure for a big-endian
+        machine:
+
+
+                  struct extract_ccb {
+                         uint32_t header;
+                         uint32_t control;
+                         uint64_t completion;
+                         uint64_t primary_input;
+                         uint64_t data_access_control;
+                         uint64_t secondary_input;
+                         uint64_t reserved;
+                         uint64_t output;
+                         uint64_t table;
+                  };
+
+
+        The exact field offsets, sizes, and composition are as follows:
+
+         Offset         Size            Field Description
+         0              4               CCB header (Table 36.1, “CCB Header Format”)
+         4              4               Command control
+                                        Bits        Field Description
+                                        [31:28]     Primary Input Format (see Section 36.2.1.1.1, “Primary Input
+                                                    Format”)
+                                        [27:23]     Primary Input Element Size (see Section 36.2.1.1.2, “Primary
+                                                    Input Element Size”)
+                                        [22:20]     Primary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                                                    Element Offsets”)
+                                        [19]        Secondary Input Format (see Section 36.2.1.1.3, “Secondary
+                                                    Input Format”)
+                                        [18:16]     Secondary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                                                    Element Offsets”)
+
+
+                                                       516
+                        Coprocessor services
+
+
+Offset   Size   Field Description
+                Bits         Field Description
+                [15:14]      Secondary Input Element Size (see Section 36.2.1.1.4, “Se-
+                             condary Input Element Size”
+                [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
+                [9]          Padding Direction selector: A value of 1 causes padding bytes
+                             to be added to the left side of output elements. A value of 0
+                             causes padding bytes to be added to the right side of output
+                             elements.
+                [8:0]        Reserved
+8        8      Completion
+                Bits         Field Description
+                [63:60]      ADI version (see Section 36.2.1.1.7, “Application Data Integri-
+                             ty (ADI)”)
+                [59]         If set to 1, a virtual device interrupt will be generated using
+                             the device interrupt number specified in the lower bits of this
+                             completion word. If 0, the lower bits of this completion word
+                             are ignored.
+                [58:6]       Completion area address bits [58:6]. Address type is deter-
+                             mined by CCB header.
+                [5:0]        Virtual device interrupt number for completion interrupt, if en-
+                             abled.
+16       8      Primary Input
+                Bits         Field Description
+                [63:60]      ADI version (see Section 36.2.1.1.7, “Application Data Integri-
+                             ty (ADI)”)
+                [59:56]      If using real address, these bits should be filled in with the page
+                             size code for the page boundary checking the guest wants the
+                             virtual machine to use when accessing this data stream (check-
+                             ing is only guaranteed to be performed when using API version
+                             1.1 and later). If using a virtual address, this field will be used
+                             as as primary input address bits [59:56].
+                [55:0]       Primary input address bits [55:0]. Address type is determined
+                             by CCB header.
+24       8      Data Access Control
+                Bits         Field Description
+                [63:62]      Flow Control
+                             Value      Description
+                             0b'00      Disable flow control
+                             0b'01      Enable flow control (only valid with "ORCL,sun4v-
+                                        dax-fc" compatible virtual device variants)
+                             0b'10      Reserved
+                             0b'11      Reserved
+                [61:60]      Reserved (API 1.0)
+
+
+                                517
+                       Coprocessor services
+
+
+Offset   Size   Field Description
+                Bits        Field Description
+                            Pipeline target (API 2.0)
+                            Value      Description
+                            0b'00      Connect to primary input
+                            0b'01      Connect to secondary input
+                            0b'10      Reserved
+                            0b'11      Reserved
+                [59:40]     Output buffer size given in units of 64 bytes, minus 1. Value of
+                            0 means 64 bytes, value of 1 means 128 bytes, etc. Buffer size is
+                            only enforced if flow control is enabled in Flow Control field.
+                [39:32]     Reserved
+                [31:30]     Output Data Cache Allocation
+                            Value      Description
+                            0b'00      Do not allocate cache lines for output data stream.
+                            0b'01      Force cache lines for output data stream to be allocat-
+                                       ed in the cache that is local to the submitting virtual
+                                       cpu.
+                            0b'10      Allocate cache lines for output data stream, but allow
+                                       existing cache lines associated with the data to remain
+                                       in their current cache instance. Any memory not al-
+                                       ready in cache will be allocated in the cache local to
+                                       the submitting virtual cpu.
+                            0b'11      Reserved
+                [29:26]     Reserved
+                [25:24]     Primary Input Length Format
+                            Value      Description
+                            0b'00      Number of primary symbols
+                            0b'01      Number of primary bytes
+                            0b'10      Number of primary bits
+                            0b'11      Reserved
+                [23:0]      Primary Input Length
+                            Format                      Field Value
+                            # of primary symbols        Number of input elements to process,
+                                                        minus 1. Command execution stops
+                                                        once count is reached.
+                            # of primary bytes          Number of input bytes to process,
+                                                        minus 1. Command execution stops
+                                                        once count is reached. The count is
+                                                        done before any decompression or
+                                                        decoding.
+                            # of primary bits           Number of input bits to process, mi-
+                                                        nus 1. Command execution stops
+
+
+
+                               518
+                                                Coprocessor services
+
+
+        Offset          Size           Field Description
+                                        Bits         Field Description
+                                                     Format                     Field Value
+                                                                                once count is reached. The count is
+                                                                                done before any decompression or
+                                                                                decoding, and does not include any
+                                                                                bits skipped by the Primary Input
+                                                                                Offset field value of the command
+                                                                                control word.
+        32              8              Secondary Input, if used by Primary Input Format. Same fields as Primary
+                                       Input.
+        40              8              Reserved
+        48              8              Output (same fields as Primary Input)
+        56              8              Symbol Table (if used by Primary Input)
+                                        Bits         Field Description
+                                        [63:60]      ADI version (see Section 36.2.1.1.7, “Application Data Integri-
+                                                     ty (ADI)”)
+                                        [59:56]      If using real address, these bits should be filled in with the page
+                                                     size code for the page boundary checking the guest wants the
+                                                     virtual machine to use when accessing this data stream (check-
+                                                     ing is only guaranteed to be performed when using API version
+                                                     1.1 and later). If using a virtual address, this field will be used
+                                                     as as symbol table address bits [59:56].
+                                        [55:4]       Symbol table address bits [55:4]. Address type is determined
+                                                     by CCB header.
+                                        [3:0]        Symbol table version
+                                                     Value     Description
+                                                     0         Huffman encoding. Must use 64 byte aligned table
+                                                               address. (Only available when using version 0 CCBs)
+                                                     1         OZIP encoding. Must use 16 byte aligned table ad-
+                                                               dress. (Only available when using version 1 CCBs)
+
+
+36.2.1.3. Scan commands
+
+        The scan commands search a stream of input data elements for values which match the selection criteria.
+        All the input format types are supported. There are multiple formats for the scan commands, allowing the
+        scan to search for exact matches to one value, exact matches to either of two values, or any value within
+        a specified range. The specific type of scan is indicated by the command code in the CCB header. For the
+        scan range commands, the boundary conditions can be specified as greater-than-or-equal-to a value, less-
+        than-or-equal-to a value, or both by using two boundary values.
+
+        There are two supported formats for the output stream: the bit vector and index array formats (codes 0x8,
+        0xD, and 0xE). For the standard scan command using the bit vector output, for each input element there
+        exists one bit in the vector that is set if the input element matched the scan criteria, or clear if not. The
+        inverted scan command inverts the polarity of the bits in the output. The most significant bit of the first
+        byte of the output stream corresponds to the first element in the input stream. The standard index array
+        output format contains one array entry for each input element that matched the scan criteria. Each array
+
+
+
+                                                         519
+                                       Coprocessor services
+
+
+entry is the index of an input element that matched the scan criteria. An inverted scan command produces
+a similar array, but of all the input elements which did NOT match the scan criteria.
+
+The return value of the CCB completion area contains the number of input elements found which match
+the scan criteria (or number that did not match for the inverted scans). The “number of elements processed”
+field in the CCB completion area will be valid, indicating the number of input elements processed.
+
+These commands are 128-byte “long format” CCBs.
+
+The scan CCB command format can be specified by the following packed C structure for a big-endian
+machine:
+
+
+         struct scan_ccb         {
+                uint32_t         header;
+                uint32_t         control;
+                uint64_t         completion;
+                uint64_t         primary_input;
+                uint64_t         data_access_control;
+                uint64_t         secondary_input;
+                uint64_t         match_criteria0;
+                uint64_t         output;
+                uint64_t         table;
+                uint64_t         match_criteria1;
+                uint64_t         match_criteria2;
+                uint64_t         match_criteria3;
+                uint64_t         reserved[5];
+         };
+
+
+The exact field offsets, sizes, and composition are as follows:
+
+Offset         Size            Field Description
+0              4               CCB header (Table 36.1, “CCB Header Format”)
+4              4               Command control
+                               Bits         Field Description
+                               [31:28]      Primary Input Format (see Section 36.2.1.1.1, “Primary Input
+                                            Format”)
+                               [27:23]      Primary Input Element Size (see Section 36.2.1.1.2, “Primary
+                                            Input Element Size”)
+                               [22:20]      Primary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                                            Element Offsets”)
+                               [19]         Secondary Input Format (see Section 36.2.1.1.3, “Secondary
+                                            Input Format”)
+                               [18:16]      Secondary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                                            Element Offsets”)
+                               [15:14]      Secondary Input Element Size (see Section 36.2.1.1.4, “Se-
+                                            condary Input Element Size”
+                               [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
+                               [9:5]        Operand size for first scan criteria value. In a scan value oper-
+                                            ation, this is one of two potential extact match values. In a scan
+                                            range operation, this is the size of the upper range boundary.
+
+
+                                               520
+                        Coprocessor services
+
+
+Offset   Size   Field Description
+                Bits         Field Description
+                             The value of this field is the number of bytes in the operand,
+                             minus 1. Values 0xF-0x1E are reserved. A value of 0x1F indi-
+                             cates this operand is not in use for this scan operation.
+                [4:0]        Operand size for second scan criteria value. In a scan value op-
+                             eration, this is one of two potential extact match values. In a
+                             scan range operation, this is the size of the lower range bound-
+                             ary. The value of this field is the number of bytes in the operand,
+                             minus 1. Values 0xF-0x1E are reserved. A value of 0x1F indi-
+                             cates this operand is not in use for this scan operation.
+8        8      Completion (same fields as Section 36.2.1.2, “Extract command”)
+16       8      Primary Input (same fields as Section 36.2.1.2, “Extract command”)
+24       8      Data Access Control (same fields as Section 36.2.1.2, “Extract command”)
+32       8      Secondary Input, if used by Primary Input Format. Same fields as Primary
+                Input.
+40       4      Most significant 4 bytes of first scan criteria operand. If first operand is less
+                than 4 bytes, the value is left-aligned to the lowest address bytes.
+44       4      Most significant 4 bytes of second scan criteria operand. If second operand
+                is less than 4 bytes, the value is left-aligned to the lowest address bytes.
+48       8      Output (same fields as Primary Input)
+56       8      Symbol Table (if used by Primary Input). Same fields as Section 36.2.1.2,
+                “Extract command”
+64       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+                bytes specified at offset 40, if needed by the operand size. If first operand
+                is less than 8 bytes, the valid bytes are left-aligned to the lowest address.
+68       4      Next 4 most significant bytes of second scan criteria operand occuring after
+                the bytes specified at offset 44, if needed by the operand size. If second
+                operand is less than 8 bytes, the valid bytes are left-aligned to the lowest
+                address.
+72       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+                bytes specified at offset 64, if needed by the operand size. If first operand
+                is less than 12 bytes, the valid bytes are left-aligned to the lowest address.
+76       4      Next 4 most significant bytes of second scan criteria operand occuring after
+                the bytes specified at offset 68, if needed by the operand size. If second
+                operand is less than 12 bytes, the valid bytes are left-aligned to the lowest
+                address.
+80       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+                bytes specified at offset 72, if needed by the operand size. If first operand
+                is less than 16 bytes, the valid bytes are left-aligned to the lowest address.
+84       4      Next 4 most significant bytes of second scan criteria operand occuring after
+                the bytes specified at offset 76, if needed by the operand size. If second
+                operand is less than 16 bytes, the valid bytes are left-aligned to the lowest
+                address.
+
+
+
+
+                                521
+                                               Coprocessor services
+
+
+36.2.1.4. Translate commands
+
+        The translate commands takes an input array of indicies, and a table of single bit values indexed by those
+        indicies, and outputs a bit vector or index array created by reading the tables bit value at each index in
+        the input array. The output should therefore contain exactly one bit per index in the input data stream,
+        when outputing as a bit vector. When outputing as an index array, the number of elements depends on the
+        values read in the bit table, but will always be less than, or equal to, the number of input elements. Only
+        a restricted subset of the possible input format types are supported. No variable width or Huffman/OZIP
+        encoded input streams are allowed. The primary input data element size must be 3 bytes or less.
+
+        The maximum table index size allowed is 15 bits, however, larger input elements may be used to provide
+        additional processing of the output values. If 2 or 3 byte values are used, the least significant 15 bits are
+        used as an index into the bit table. The most significant 9 bits (when using 3-byte input elements) or single
+        bit (when using 2-byte input elements) are compared against a fixed 9-bit test value provided in the CCB.
+        If the values match, the value from the bit table is used as the output element value. If the values do not
+        match, the output data element value is forced to 0.
+
+        In the inverted translate operation, the bit value read from bit table is inverted prior to its use. The additional
+        additional processing based on any additional non-index bits remains unchanged, and still forces the output
+        element value to 0 on a mismatch. The specific type of translate command is indicated by the command
+        code in the CCB header.
+
+        There are two supported formats for the output stream: the bit vector and index array formats (codes 0x8,
+        0xD, and 0xE). The index array format is an array of indicies of bits which would have been set if the
+        output format was a bit array.
+
+        The return value of the CCB completion area contains the number of bits set in the output bit vector,
+        or number of elements in the output index array. The “number of elements processed” field in the CCB
+        completion area will be valid, indicating the number of input elements processed.
+
+        These commands are 64-byte “short format” CCBs.
+
+        The translate CCB command format can be specified by the following packed C structure for a big-endian
+        machine:
+
+
+                 struct translate_ccb {
+                        uint32_t header;
+                        uint32_t control;
+                        uint64_t completion;
+                        uint64_t primary_input;
+                        uint64_t data_access_control;
+                        uint64_t secondary_input;
+                        uint64_t reserved;
+                        uint64_t output;
+                        uint64_t table;
+                 };
+
+
+        The exact field offsets, sizes, and composition are as follows:
+
+
+        Offset          Size             Field Description
+        0               4                CCB header (Table 36.1, “CCB Header Format”)
+
+
+                                                        522
+                        Coprocessor services
+
+
+Offset   Size   Field Description
+4        4      Command control
+                Bits         Field Description
+                [31:28]      Primary Input Format (see Section 36.2.1.1.1, “Primary Input
+                             Format”)
+                [27:23]      Primary Input Element Size (see Section 36.2.1.1.2, “Primary
+                             Input Element Size”)
+                [22:20]      Primary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                             Element Offsets”)
+                [19]         Secondary Input Format (see Section 36.2.1.1.3, “Secondary
+                             Input Format”)
+                [18:16]      Secondary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                             Element Offsets”)
+                [15:14]      Secondary Input Element Size (see Section 36.2.1.1.4, “Se-
+                             condary Input Element Size”
+                [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
+                [9]          Reserved
+                [8:0]        Test value used for comparison against the most significant bits
+                             in the input values, when using 2 or 3 byte input elements.
+8        8      Completion (same fields as Section 36.2.1.2, “Extract command”
+16       8      Primary Input (same fields as Section 36.2.1.2, “Extract command”
+24       8      Data Access Control (same fields as Section 36.2.1.2, “Extract command”,
+                except Primary Input Length Format may not use the 0x0 value)
+32       8      Secondary Input, if used by Primary Input Format. Same fields as Primary
+                Input.
+40       8      Reserved
+48       8      Output (same fields as Primary Input)
+56       8      Bit Table
+                Bits         Field Description
+                [63:60]      ADI version (see Section 36.2.1.1.7, “Application Data Integri-
+                             ty (ADI)”)
+                [59:56]      If using real address, these bits should be filled in with the page
+                             size code for the page boundary checking the guest wants the
+                             virtual machine to use when accessing this data stream (check-
+                             ing is only guaranteed to be performed when using API version
+                             1.1 and later). If using a virtual address, this field will be used
+                             as as bit table address bits [59:56]
+                [55:4]       Bit table address bits [55:4]. Address type is determined by
+                             CCB header. Address must be 64-byte aligned (CCB version
+                             0) or 16-byte aligned (CCB version 1).
+                [3:0]        Bit table version
+                             Value      Description
+                             0          4KB table size
+                             1          8KB table size
+
+
+
+                                 523
+                                              Coprocessor services
+
+
+36.2.1.5. Select command
+        The select command filters the primary input data stream by using a secondary input bit vector to determine
+        which input elements to include in the output. For each bit set at a given index N within the bit vector,
+        the Nth input element is included in the output. If the bit is not set, the element is not included. Only a
+        restricted subset of the possible input format types are supported. No variable width or run length encoded
+        input streams are allowed, since the secondary input stream is used for the filtering bit vector.
+
+        The only supported output format is a padded, byte-aligned output stream. The stream follows the same
+        rules and restrictions as padded output stream described in Section 36.2.1.2, “Extract command”.
+
+        The return value of the CCB completion area contains the number of bits set in the input bit vector. The
+        "number of elements processed" field in the CCB completion area will be valid, indicating the number
+        of input elements processed.
+
+        The select CCB is a 64-byte “short format” CCB.
+
+        The select CCB command format can be specified by the following packed C structure for a big-endian
+        machine:
+
+
+                  struct select_ccb {
+                         uint32_t header;
+                         uint32_t control;
+                         uint64_t completion;
+                         uint64_t primary_input;
+                         uint64_t data_access_control;
+                         uint64_t secondary_input;
+                         uint64_t reserved;
+                         uint64_t output;
+                         uint64_t table;
+                  };
+
+
+        The exact field offsets, sizes, and composition are as follows:
+
+         Offset        Size            Field Description
+         0             4               CCB header (Table 36.1, “CCB Header Format”)
+         4             4               Command control
+                                       Bits        Field Description
+                                       [31:28]     Primary Input Format (see Section 36.2.1.1.1, “Primary Input
+                                                   Format”)
+                                       [27:23]     Primary Input Element Size (see Section 36.2.1.1.2, “Primary
+                                                   Input Element Size”)
+                                       [22:20]     Primary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                                                   Element Offsets”)
+                                       [19]        Secondary Input Format (see Section 36.2.1.1.3, “Secondary
+                                                   Input Format”)
+                                       [18:16]     Secondary Input Starting Offset (see Section 36.2.1.1.5, “Input
+                                                   Element Offsets”)
+                                       [15:14]     Secondary Input Element Size (see Section 36.2.1.1.4, “Se-
+                                                   condary Input Element Size”
+
+
+                                                      524
+                                               Coprocessor services
+
+
+        Offset         Size            Field Description
+                                       Bits         Field Description
+                                       [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
+                                       [9]          Padding Direction selector: A value of 1 causes padding bytes
+                                                    to be added to the left side of output elements. A value of 0
+                                                    causes padding bytes to be added to the right side of output
+                                                    elements.
+                                       [8:0]        Reserved
+        8              8               Completion (same fields as Section 36.2.1.2, “Extract command”
+        16             8               Primary Input (same fields as Section 36.2.1.2, “Extract command”
+        24             8               Data Access Control (same fields as Section 36.2.1.2, “Extract command”)
+        32             8               Secondary Bit Vector Input. Same fields as Primary Input.
+        40             8               Reserved
+        48             8               Output (same fields as Primary Input)
+        56             8               Symbol Table (if used by Primary Input). Same fields as Section 36.2.1.2,
+                                       “Extract command”
+
+36.2.1.6. No-op and Sync commands
+
+        The no-op (no operation) command is a CCB which has no processing effect. The CCB, when processed
+        by the virtual machine, simply updates the completion area with its execution status. The CCB may have
+        the serial-conditional flags set in order to restrict when it executes.
+
+        The sync command is a variant of the no-op command which with restricted execution timing. A sync
+        command CCB will only execute when all previous commands submitted in the same request have com-
+        pleted. This is stronger than the conditional flag sequencing, which is only dependent on a single previous
+        serial CCB. While the relative ordering is guaranteed, virtual machine implementations with shared hard-
+        ware resources may cause the sync command to wait for longer than the minimum required time.
+
+        The return value of the CCB completion area is invalid for these CCBs. The “number of elements
+        processed” field is also invalid for these CCBs.
+
+        These commands are 64-byte “short format” CCBs.
+
+        The no-op CCB command format can be specified by the following packed C structure for a big-endian
+        machine:
+
+
+                 struct nop_ccb {
+                        uint32_t header;
+                        uint32_t control;
+                        uint64_t completion;
+                        uint64_t reserved[6];
+                 };
+
+
+        The exact field offsets, sizes, and composition are as follows:
+
+        Offset         Size            Field Description
+        0              4               CCB header (Table 36.1, “CCB Header Format”)
+
+
+                                                       525
+                                          Coprocessor services
+
+
+       Offset        Size          Field Description
+       4             4             Command control
+                                   Bits        Field Description
+                                   [31]        If set, this CCB functions as a Sync command. If clear, this
+                                               CCB functions as a No-op command.
+                                   [30:0]      Reserved
+       8             8             Completion (same fields as Section 36.2.1.2, “Extract command”
+       16            46            Reserved
+
+36.2.2. CCB Completion Area
+       All CCB commands use a common 128-byte Completion Area format, which can be specified by the
+       following packed C structure for a big-endian machine:
+
+
+                struct completion_area {
+                       uint8_t status_flag;
+                       uint8_t error_note;
+                       uint8_t rsvd0[2];
+                       uint32_t error_values;
+                       uint32_t output_size;
+                       uint32_t rsvd1;
+                       uint64_t run_time;
+                       uint64_t run_stats;
+                       uint32_t elements;
+                       uint8_t rsvd2[20];
+                       uint64_t return_value;
+                       uint64_t extra_return_value[8];
+                };
+
+
+       The Completion Area must be a 128-byte aligned memory location. The exact layout can be described
+       using byte offsets and sizes relative to the memory base:
+
+       Offset        Size          Field Description
+       0             1             CCB execution status
+                                   0x0                  Command not yet completed
+                                   0x1                  Command ran and succeeded
+                                   0x2                  Command ran and failed (partial results may be been
+                                                        produced)
+                                   0x3                  Command ran and was killed (partial execution may
+                                                        have occurred)
+                                   0x4                  Command was not run
+                                   0x5-0xF              Reserved
+       1             1             Error reason code
+                                   0x0                  Reserved
+                                   0x1                  Buffer overflow
+
+
+                                                  526
+                                      Coprocessor services
+
+
+Offset          Size           Field Description
+                                0x2                 CCB decoding error
+                                0x3                 Page overflow
+                                0x4-0x6             Reserved
+                                0x7                 Command was killed
+                                0x8                 Command execution timeout
+                                0x9                 ADI miscompare error
+                                0xA                 Data format error
+                                0xB-0xD             Reserved
+                                0xE                 Unexpected hardware error (Do not retry)
+                                0xF                 Unexpected hardware error (Retry is ok)
+                                0x10-0x7F           Reserved
+                                0x80                Partial Symbol Warning
+                                0x81-0xFF           Reserved
+2               2              Reserved
+4               4              If a partial symbol warning was generated, this field contains the number
+                               of remaining bits which were not decoded.
+8               4              Number of bytes of output produced
+12              4              Reserved
+16              8              Runtime of command (unspecified time units)
+24              8              Reserved
+32              4              Number of elements processed
+36              20             Reserved
+56              8              Return value
+64              64             Extended return value
+
+The CCB completion area should be treated as read-only by guest software. The CCB execution status
+byte will be cleared by the Hypervisor to reflect the pending execution status when the CCB is submitted
+successfully. All other fields are considered invalid upon CCB submission until the CCB execution status
+byte becomes non-zero.
+
+CCBs which complete with status 0x2 or 0x3 may produce partial results and/or side effects due to partial
+execution of the CCB command. Some valid data may be accessible depending on the fault type, however,
+it is recommended that guest software treat the destination buffer as being in an unknown state. If a CCB
+completes with a status byte of 0x2, the error reason code byte can be read to determine what corrective
+action should be taken.
+
+A buffer overflow indicates that the results of the operation exceeded the size of the output buffer indicated
+in the CCB. The operation can be retried by resubmitting the CCB with a larger output buffer.
+
+A CCB decoding error indicates that the CCB contained some invalid field values. It may be also be
+triggered if the CCB output is directed at a non-existent secondary input and the pipelining hint is followed.
+
+A page overflow error indicates that the operation required accessing a memory location beyond the page
+size associated with a given address. No data will have been read or written past the page boundary, but
+partial results may have been written to the destination buffer. The CCB can be resubmitted with a larger
+page size memory allocation to complete the operation.
+
+
+                                              527
+                                            Coprocessor services
+
+
+       In the case of pipelined CCBs, a page overflow error will be triggered if the output from the pipeline source
+       CCB ends before the input of the pipeline target CCB. Page boundaries are ignored when the pipeline
+       hint is followed.
+
+       Command kill indicates that the CCB execution was halted or prevented by use of the ccb_kill API call.
+
+       Command timeout indicates that the CCB execution began, but did not complete within a pre-determined
+       limit set by the virtual machine. The command may have produced some or no output. The CCB may be
+       resubmitted with no alterations.
+
+       ADI miscompare indicates that the memory buffer version specified in the CCB did not match the value
+       in memory when accessed by the virtual machine. Guest software should not attempt to resubmit the CCB
+       without determining the cause of the version mismatch.
+
+       A data format error indicates that the input data stream did not follow the specified data input formatting
+       selected in the CCB.
+
+       Some CCBs which encounter hardware errors may be resubmitted without change. Persistent hardware
+       errors may result in multiple failures until RAS software can identify and isolate the faulty component.
+
+       The output size field indicates the number of bytes of valid output in the destination buffer. This field is
+       not valid for all possible CCB commands.
+
+       The runtime field indicates the execution time of the CCB command once it leaves the internal virtual
+       machine queue. The time units are fixed, but unspecified, allowing only relative timing comparisons by
+       guest software. The time units may also vary by hardware platform, and should not be construed to rep-
+       resent any absolute time value.
+
+       Some data query commands process data in units of elements. If applicable to the command, the number of
+       elements processed is indicated in the listed field. This field is not valid for all possible CCB commands.
+
+       The return value and extended return value fields are output locations for commands which do not use
+       a destination output buffer, or have secondary return results. The field is not valid for all possible CCB
+       commands.
+
+36.3. Hypervisor API Functions
+36.3.1. ccb_submit
+       trap#             FAST_TRAP
+       function#         CCB_SUBMIT
+       arg0              address
+       arg1              length
+       arg2              flags
+       arg3              reserved
+       ret0              status
+       ret1              length
+       ret2              status data
+       ret3              reserved
+
+       Submit one or more coprocessor control blocks (CCBs) for evaluation and processing by the virtual ma-
+       chine. The CCBs are passed in a linear array indicated by address. length indicates the size of the
+       array in bytes.
+
+
+                                                     528
+                                      Coprocessor services
+
+
+The address should be aligned to the size indicated by length, rounded up to the nearest power of
+two. Virtual machines implementations may reject submissions which do not adhere to that alignment.
+length must be a multiple of 64 bytes. If length is zero, the maximum supported array length will be
+returned as length in ret1. In all other cases, the length value in ret1 will reflect the number of bytes
+successfully consumed from the input CCB array.
+
+      Implementation note
+      Virtual machines should never reject submissions based on the alignment of address if the
+      entire array is contained within a single memory page of the smallest page size supported by the
+      virtual machine.
+
+A guest may choose to submit addresses used in this API function, including the CCB array address,
+as either a real or virtual addresses, with the type of each address indicated in flags. Virtual addresses
+must be present in either the TLB or an active TSB to be processed. The translation context for virtual
+addresses is determined by a combination of CCB contents and the flags argument.
+
+The flags argument is divided into multiple fields defined as follows:
+
+
+Bits            Field Description
+[63:16]         Reserved
+[15]            Disable ADI for VA reads (in API 2.0)
+                Reserved (in API 1.0)
+[14]            Virtual addresses within CCBs are translated in privileged context
+[13:12]         Alternate translation context for virtual addresses within CCBs:
+                 0b'00        CCBs requesting alternate context are rejected
+                 0b'01        Reserved
+                 0b'10        CCBs requesting alternate context use secondary context
+                 0b'11        CCBs requesting alternate context use nucleus context
+[11:9]          Reserved
+[8]             Queue info flag
+[7]             All-or-nothing flag
+[6]             If address is a virtual address, treat its translation context as privileged
+[5:4]           Address type of address:
+                 0b'00        Real address
+                 0b'01        Virtual address in primary context
+                 0b'10        Virtual address in secondary context
+                 0b'11        Virtual address in nucleus context
+[3:2]           Reserved
+[1:0]           CCB command type:
+                 0b'00        Reserved
+                 0b'01        Reserved
+                 0b'10        Query command
+                 0b'11        Reserved
+
+
+
+                                              529
+                                              Coprocessor services
+
+
+         The CCB submission type and address type for the CCB array must be provided in the flags argument.
+         All other fields are optional values which change the default behavior of the CCB processing.
+
+         When set to one, the "Disable ADI for VA reads" bit will turn off ADI checking when using a virtual
+         address to load data. ADI checking will still be done when loading real-addressed memory. This bit is only
+         available when using major version 2 of the coprocessor API group; at major version 1 it is reserved. For
+         more information about using ADI and DAX, see Section 36.2.1.1.7, “Application Data Integrity (ADI)”.
+
+         By default, all virtual addresses are treated as user addresses. If the virtual address translations are privi-
+         leged, they must be marked as such in the appropriate flags field. The virtual addresses used within the
+         submitted CCBs must all be translated with the same privilege level.
+
+         By default, all virtual addresses used within the submitted CCBs are translated using the primary context
+         active at the time of the submission. The address type field within a CCB allows each address to request
+         translation in an alternate address context. The address context used when the alternate address context is
+         requested is selected in the flags argument.
+
+         The all-or-nothing flag specifies whether the virtual machine should allow partial submissions of the input
+         CCB array. When using CCBs with serial-conditional flags, it is strongly recommended to use the all-
+         or-nothing flag to avoid broken conditional chains. Using long CCB chains on a machine under high co-
+         processor load may make this impractical, however, and require submitting without the flag. When sub-
+         mitting serial-conditional CCBs without the all-or-nothing flag, guest software must manually implement
+         the serial-conditional behavior at any point where the chain was not submitted in a single API call, and re-
+         submission of the remaining CCBs should clear any conditional flag that might be set in the first remaining
+         CCB. Failure to do so will produce indeterminate CCB execution status and ordering.
+
+         When the all-or-nothing flag is not specified, callers should check the value of length in ret1 to determine
+         how many CCBs from the array were successfully submitted. Any remaining CCBs can be resubmitted
+         without modifications.
+
+         The value of length in ret1 is also valid when the API call returns an error, and callers should always
+         check its value to determine which CCBs in the array were already processed. This will additionally iden-
+         tify which CCB encountered the processing error, and was not submitted successfully.
+
+         If the queue info flag is used during submission, and at least one CCB was successfully submitted, the
+         length value in ret1 will be a multi-field value defined as follows:
+          Bits           Field Description
+          [63:48]        DAX unit instance identifier
+          [47:32]        DAX queue instance identifier
+          [31:16]        Reserved
+          [15:0]         Number of CCB bytes successfully submitted
+
+         The value of status data depends on the status value. See error status code descriptions for details.
+         The value is undefined for status values that do not specifically list a value for the status data.
+
+         The API has a reserved input and output register which will be used in subsequent minor versions of this
+         API function. Guest software implementations should treat that register as voltile across the function call
+         in order to maintain forward compatibility.
+
+36.3.1.1. Errors
+          EOK                        One or more CCBs have been accepted and enqueued in the virtual machine
+                                     and no errors were been encountered during submission. Some submitted
+                                     CCBs may not have been enqueued due to internal virtual machine limitations,
+                                     and may be resubmitted without changes.
+
+
+                                                        530
+                        Coprocessor services
+
+
+EWOULDBLOCK    An internal resource conflict within the virtual machine has prevented it from
+               being able to complete the CCB submissions sufficiently quickly, requiring
+               it to abandon processing before it was complete. Some CCBs may have been
+               successfully enqueued prior to the block, and all remaining CCBs may be re-
+               submitted without changes.
+EBADALIGN      CCB array is not on a 64-byte boundary, or the array length is not a multiple
+               of 64 bytes.
+ENORADDR       A real address used either for the CCB array, or within one of the submitted
+               CCBs, is not valid for the guest. Some CCBs may have been enqueued prior
+               to the error being detected.
+ENOMAP         A virtual address used either for the CCB array, or within one of the submitted
+               CCBs, could not be translated by the virtual machine using either the TLB or
+               TSB contents. The submission may be retried after adding the required map-
+               ping, or by converting the virtual address into a real address. Due to the shared
+               nature of address translation resources, there is no theoretical limit on the num-
+               ber of times the translation may fail, and it is recommended all guests imple-
+               ment some real address based backup. The virtual address which failed trans-
+               lation is returned as status data in ret2. Some CCBs may have been en-
+               queued prior to the error being detected.
+EINVAL         The virtual machine detected an invalid CCB during submission, or invalid
+               input arguments, such as bad flag values. Note that not all invalid CCB values
+               will be detected during submission, and some may be reported as errors in the
+               completion area instead. Some CCBs may have been enqueued prior to the
+               error being detected. This error may be returned if the CCB version is invalid.
+ETOOMANY       The request was submitted with the all-or-nothing flag set, and the array size is
+               greater than the virtual machine can support in a single request. The maximum
+               supported size for the current virtual machine can be queried by submitting a
+               request with a zero length array, as described above.
+ENOACCESS      The guest does not have permission to submit CCBs, or an address used in a
+               CCBs lacks sufficient permissions to perform the required operation (no write
+               permission on the destination buffer address, for example). A virtual address
+               which fails permission checking is returned as status data in ret2. Some
+               CCBs may have been enqueued prior to the error being detected.
+EUNAVAILABLE   The requested CCB operation could not be performed at this time. The restrict-
+               ed operation availability may apply only to the first unsuccessfully submitted
+               CCB, or may apply to a larger scope. The status should not be interpreted as
+               permanent, and the guest should attempt to submit CCBs in the future which
+               had previously been unable to be performed. The status data provides
+               additional information about scope of the retricted availability as follows:
+               Value       Description
+               0           Processing for the exact CCB instance submitted was unavailable,
+                           and it is recommended the guest emulate the operation. The guest
+                           should continue to submit all other CCBs, and assume no restric-
+                           tions beyond this exact CCB instance.
+               1           Processing is unavailable for all CCBs using the requested opcode,
+                           and it is recommended the guest emulate the operation. The guest
+                           should continue to submit all other CCBs that use different op-
+                           codes, but can expect continued rejections of CCBs using the same
+                           opcode in the near future.
+
+
+
+
+                                 531
+                                              Coprocessor services
+
+
+                                      Value     Description
+                                      2         Processing is unavailable for all CCBs using the requested CCB
+                                                version, and it is recommended the guest emulate the operation.
+                                                The guest should continue to submit all other CCBs that use dif-
+                                                ferent CCB versions, but can expect continued rejections of CCBs
+                                                using the same CCB version in the near future.
+                                      3         Processing is unavailable for all CCBs on the submitting vcpu,
+                                                and it is recommended the guest emulate the operation or resubmit
+                                                the CCB on a different vcpu. The guest should continue to submit
+                                                CCBs on all other vcpus but can expect continued rejections of all
+                                                CCBs on this vcpu in the near future.
+                                      4         Processing is unavailable for all CCBs, and it is recommended the
+                                                guest emulate the operation. The guest should expect all CCB sub-
+                                                missions to be similarly rejected in the near future.
+
+
+36.3.2. ccb_info
+
+        trap#               FAST_TRAP
+        function#           CCB_INFO
+        arg0                address
+        ret0                status
+        ret1                CCB state
+        ret2                position
+        ret3                dax
+        ret4                queue
+
+       Requests status information on a previously submitted CCB. The previously submitted CCB is identified
+       by the 64-byte aligned real address of the CCBs completion area.
+
+       A CCB can be in one of 4 states:
+
+
+        State                     Value       Description
+        COMPLETED                 0           The CCB has been fetched and executed, and is no longer active in
+                                              the virtual machine.
+        ENQUEUED                  1           The requested CCB is current in a queue awaiting execution.
+        INPROGRESS                2           The CCB has been fetched and is currently being executed. It may still
+                                              be possible to stop the execution using the ccb_kill hypercall.
+        NOTFOUND                  3           The CCB could not be located in the virtual machine, and does not
+                                              appear to have been executed. This may occur if the CCB was lost
+                                              due to a hardware error, or the CCB may not have been successfully
+                                              submitted to the virtual machine in the first place.
+
+               Implementation note
+               Some platforms may not be able to report CCBs that are currently being processed, and therefore
+               guest software should invoke the ccb_kill hypercall prior to assuming the request CCB will never
+               be executed because it was in the NOTFOUND state.
+
+
+                                                       532
+                                             Coprocessor services
+
+
+         The position return value is only valid when the state is ENQUEUED. The value returned is the number
+         of other CCBs ahead of the requested CCB, to provide a relative estimate of when the CCB may execute.
+
+         The dax return value is only valid when the state is ENQUEUED. The value returned is the DAX unit
+         instance indentifier for the DAX unit processing the queue where the requested CCB is located. The value
+         matches the value that would have been, or was, returned by ccb_submit using the queue info flag.
+
+         The queue return value is only valid when the state is ENQUEUED. The value returned is the DAX
+         queue instance indentifier for the DAX unit processing the queue where the requested CCB is located. The
+         value matches the value that would have been, or was, returned by ccb_submit using the queue info flag.
+
+36.3.2.1. Errors
+
+          EOK                       The request was proccessed and the CCB state is valid.
+          EBADALIGN                 address is not on a 64-byte aligned.
+          ENORADDR                  The real address provided for address is not valid.
+          EINVAL                    The CCB completion area contents are not valid.
+          EWOULDBLOCK               Internal resource contraints prevented the CCB state from being queried at this
+                                    time. The guest should retry the request.
+          ENOACCESS                 The guest does not have permission to access the coprocessor virtual device
+                                    functionality.
+
+36.3.3. ccb_kill
+
+          trap#           FAST_TRAP
+          function#       CCB_KILL
+          arg0            address
+          ret0            status
+          ret1            result
+
+         Request to stop execution of a previously submitted CCB. The previously submitted CCB is identified by
+         the 64-byte aligned real address of the CCBs completion area.
+
+         The kill attempt can produce one of several values in the result return value, reflecting the CCB state
+         and actions taken by the Hypervisor:
+
+          Result                Value       Description
+          COMPLETED             0           The CCB has been fetched and executed, and is no longer active in
+                                            the virtual machine. It could not be killed and no action was taken.
+          DEQUEUED              1           The requested CCB was still enqueued when the kill request was sub-
+                                            mitted, and has been removed from the queue. Since the CCB never
+                                            began execution, no memory modifications were produced by it, and
+                                            the completion area will never be updated. The same CCB may be
+                                            submitted again, if desired, with no modifications required.
+          KILLED                2           The CCB had been fetched and was being executed when the kill re-
+                                            quest was submitted. The CCB execution was stopped, and the CCB
+                                            is no longer active in the virtual machine. The CCB completion area
+                                            will reflect the killed status, with the subsequent implications that par-
+                                            tial results may have been produced. Partial results may include full
+
+
+                                                      533
+                                              Coprocessor services
+
+
+          Result                 Value       Description
+                                             command execution if the command was stopped just prior to writing
+                                             to the completion area.
+          NOTFOUND               3           The CCB could not be located in the virtual machine, and does not
+                                             appear to have been executed. This may occur if the CCB was lost
+                                             due to a hardware error, or the CCB may not have been successfully
+                                             submitted to the virtual machine in the first place. CCBs in the state
+                                             are guaranteed to never execute in the future unless resubmitted.
+
+36.3.3.1. Interactions with Pipelined CCBs
+
+         If the pipeline target CCB is killed but the pipeline source CCB was skipped, the completion area of the
+         target CCB may contain status (4,0) "Command was skipped" instead of (3,7) "Command was killed".
+
+         If the pipeline source CCB is killed, the pipeline target CCB's completion status may read (1,0) "Success".
+         This does not mean the target CCB was processed; since the source CCB was killed, there was no mean-
+         ingful output on which the target CCB could operate.
+
+36.3.3.2. Errors
+
+          EOK                        The request was proccessed and the result is valid.
+          EBADALIGN                  address is not on a 64-byte aligned.
+          ENORADDR                   The real address provided for address is not valid.
+          EINVAL                     The CCB completion area contents are not valid.
+          EWOULDBLOCK                Internal resource contraints prevented the CCB from being killed at this time.
+                                     The guest should retry the request.
+          ENOACCESS                  The guest does not have permission to access the coprocessor virtual device
+                                     functionality.
+
+
+
+
+                                                       534
+
diff --git a/Documentation/sparc/oradax/dax1_ccb.h b/Documentation/sparc/oradax/dax1_ccb.h
new file mode 100644
index 0000000..00a61c3
--- /dev/null
+++ b/Documentation/sparc/oradax/dax1_ccb.h
@@ -0,0 +1,591 @@
+/*
+** Libdax
+**
+** Copyright © 2016, 2017 Oracle corp.  All rights reserved.
+** The Universal Permissive License (UPL), Version 1.0
+**
+** Subject to the condition set forth below, permission is hereby granted to any person obtaining a copy of this
+** software, associated documentation and/or data (collectively the "Software"), free of charge and under any and
+** all copyright rights in the Software, and any and all patent rights owned or freely licensable by each licensor
+** hereunder covering either (i) the unmodified Software as contributed to or provided by such licensor, or
+** (ii) the Larger Works (as defined below), to deal in both
+**
+** (a) the Software, and
+** (b) any piece of software and/or hardware listed in the lrgrwrks.txt file if one is included with the Software
+** (each a “Larger Work” to which the Software is contributed by such licensors),
+**
+** without restriction, including without limitation the rights to copy, create derivative works of, display,
+** perform, and distribute the Software and make, use, sell, offer for sale, import, export, have made, and have
+** sold the Software and the Larger Work(s), and to sublicense the foregoing rights on either these or other terms.
+**
+** This license is subject to the following condition:
+** The above copyright notice and either this complete permission notice or at a minimum a reference to the UPL must
+** be included in all copies or substantial portions of the Software.
+**
+** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
+** THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
+** CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+** IN THE SOFTWARE.
+*/
+
+/*
+ * The CCB interface is *not* a supported interface for using DAX. To use DAX,
+ * an application should call libdax. This will protect the application from
+ * possible changes to the CCB format in different hardware versions.
+ */
+
+#ifndef	_DAX1_CCB_H
+#define	_DAX1_CCB_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <sys/types.h>
+#include <sys/sysmacros.h>
+#include <inttypes.h>
+#endif
+
+/* General definitions */
+
+/* For converting less1 encoded fields */
+#define	DAX_LESS1(n)	((n) - 1)
+#define	DAX_ADD1(n)	((n) + 1)
+
+/* Map 1,2,4,8 to 0,1,2,3.  Does not check for bad input; caller beware. */
+
+static inline uint64_t			/* LINTED E_STATIC_UNUSED */
+dax_log2(uint64_t val)
+{
+	val /= 2;
+	if (val = 4)
+		val = 3;
+	return (val);
+}
+
+/* A number must be 1, 2, 4, or 8 to be valid as input to dax_log2() */
+#define	DAX_LOG2_MASK		((1 << 1) | (1 << 2) | (1 << 4) | (1 << 8))
+#define	DAX_LOG2_VALID(n)	((1<<(n)) & DAX_LOG2_MASK)
+
+/*
+ * Changes bits into bytes needed to hold those bits.  For example,
+ * if bits = 3, bytes = 1.
+ */
+#define	BITS_TO_BYTES(bits)					\
+	(P2ROUNDUP((bits), 8) >> 3)
+
+#define	DAX_MAX_ELEM_WIDTH	16	/* in bytes */
+
+/* Values for dax_header_t members. */
+
+/* dax_header_t ccb_version */
+#define	DAX1_CCB_VERSION 0
+#define	DAX2_CCB_VERSION 1
+
+/* dax_header_t opcode */
+#define	DAX_OP_SYNC_NOP		0x0
+#define	DAX_OP_EXTRACT		0x1
+#define	DAX_OP_SCAN_VALUE	0x2
+#define	DAX_OP_SCAN_RANGE	0x3
+#define	DAX_OP_TRANSLATE	0x4
+#define	DAX_OP_SELECT		0x5
+#define	DAX_OP_INVERT		0x10	/* OR with translate, scan opcodes */
+
+/*
+ * For M7, copy and fill both use the extract command
+ * to do the operation. So, below opcodes are defined
+ * to make the distinction between the two while
+ * postprocessing.
+ */
+#define	DAX_COPY	0x01
+#define	DAX_FILL	0x02
+
+/*
+ * dax_header_t table_addr_type, out_addr_type, sec_addr_type, pri_addr_type,
+ * cca_addr_type
+ */
+#define	DAX_ADDR_TYPE_NONE	0
+#define	DAX_ADDR_TYPE_VA	3	/* virtual address */
+
+/* Values for dax_control_t members. */
+
+/* dax_control_t pri_fmt */
+#define	DAX_PRI_FMT_BITS	(1 << 0)	/* 1 for bits, 0 for bytes */
+#define	DAX_PRI_FMT_VAR		(1 << 1)	/* 1 for var, 0 for fixed */
+#define	DAX_PRI_FMT_RLE		(1 << 2)	/* 1 for rle */
+#define	DAX_PRI_FMT_HUFF	(1 << 3)	/* 1 for huffman (aka zip) */
+
+/* dax_control_t pri_elem_size */
+#define	DAX_PRI_ELEM_SIZE(n)	DAX_LESS1(n)
+
+/* dax_control_t pri_offset */
+#define	DAX_PRI_OFFSET(n)	(n)
+
+/* dax_control_t sec_encoding */
+#define	DAX_SEC_ENCODING_ACTUAL 1
+#define	DAX_SEC_ENCODING_LESS1	0
+
+/* dax_control_t sec_offset */
+#define	DAX_SEC_OFFSET(n)	(n)
+
+/* dax_control_t sec_elem_size */
+#define	DAX_SEC_ELEM_SIZE(n)	dax_log2(n)
+
+/* dax_control_t out_fmt */
+#define	DAX_OUT_FMT_BYTES	0		/* 1 to 8 bytes */
+#define	DAX_OUT_FMT_16B		1		/* 16 bytes. size 0. */
+#define	DAX_OUT_FMT_BIT		2		/* bit vector. size 0. */
+#define	DAX_OUT_FMT_INDEX	3		/* ones index. size 2B or 4B */
+
+/*
+ * dax_control_t out_elem_size
+ * For DAX_OUT_FMT_BIT and DAX_OUT_FMT_16B, set out_elem_size = 0.
+ * For DAX_OUT_FMT_BYTES and DAX_OUT_FMT_INDEX, use this macro.
+ */
+#define	DAX_OUT_ELEM_SIZE(n)	dax_log2(n)
+
+/* dax_extract_control_t pad_dir */
+#define	DAX_PAD_DIR_RIGHT	0
+#define	DAX_PAD_DIR_LEFT	1
+
+/* dax_scan_control_t u_size, l_size */
+#define	DAX_LU_DISABLE		31
+#define	DAX_LU_SIZE(n)		DAX_LESS1(n)
+
+/* dax_nop_control_t ext_opcode */
+#define	DAX_EXT_OPCODE_NOP	0
+#define	DAX_EXT_OPCODE_SYNC	1
+
+/* Values for dax_control_t members. */
+
+/* dax_data_access_t flow_ctrl */
+#define	DAX_FLOW_CTRL_DISABLE	0
+#define	DAX_FLOW_CTRL_LIMIT	2
+
+/* dax_data_access_t pipe_target */
+#define	DAX_PIPE_TARGET_PRI	0
+#define	DAX_PIPE_TARGET_SEC	1
+
+/* dax_data_access_t out_buf_size */
+#define	DAX_OUT_BUF_SIZE(nbytes)	\
+	(((((nbytes) + 63) >> 6) - 1) & DAX_OUT_BUF_SIZE_MASK)
+#ifdef TRUNCATE
+/* Reduce limits for testing */
+#define	DAX_OUT_BUF_SIZE_MAX	(256 * 1024)		/* in bytes */
+#define	DAX_OUT_BUF_SIZE_MASK	0xfff
+#else
+#define	DAX_OUT_BUF_SIZE_MAX	(64 * 1024 * 1024)	/* in bytes */
+#define	DAX_OUT_BUF_SIZE_MASK	0xfffff
+#endif
+
+/* dax_data_access_t out_alloc */
+#define	DAX_OUT_ALLOC_NONE	0
+#define	DAX_OUT_ALLOC_HARD	(1 << 3)
+#define	DAX_OUT_ALLOC_SOFT	(2 << 3)
+
+/* dax_data_access_t pri_len_fmt */
+#define	DAX_PRI_LEN_FMT_SYMS	0
+#define	DAX_PRI_LEN_FMT_BYTES	1
+#define	DAX_PRI_LEN_FMT_BITS	2
+
+/* dax_data_access_t pri_len */
+#define	DAX_PRI_LEN(n)		(DAX_LESS1(n) & DAX_PRI_LEN_MASK)
+
+/*
+ * DAX_PRI_LEN_MAX is the max allowed pri_len under optimal conditions.
+ * DAX_PRI_LEN_LIMIT is a lower limit that applies under certain conditions.
+ * See its use in the code for details.  Define TRUNCATE to reduce the limits
+ * during testing, so more conditions can be tested using shorter vectors.
+ */
+#ifdef TRUNCATE
+#define	DAX_PRI_LEN_MAX		(64*1024)		/* max before less 1 */
+#define	DAX_PRI_LEN_MASK	0xffff
+#else
+#define	DAX_PRI_LEN_MAX		(16*1024*1024)		/* max before less 1 */
+#define	DAX_PRI_LEN_MASK	0xffffff
+#endif
+#define	DAX_PRI_LEN_LIMIT	(DAX_PRI_LEN_MAX - 64)	/* max before less 1 */
+
+/* dax_extract_ccb_t huff. OR with ozip table address on M8 */
+#define	DAX_ZIP_TABLE_VERSION_M8	1
+
+#define	DAX_LONGCCB_SHIFT 26	/* shift longccb bit to lsb */
+#define	DAX_PIPECCB_SHIFT 27	/* shift pipeccb bit to lsb */
+
+typedef struct {
+	uint32_t ccb_version:4;	/* 31:28 CCB Version */
+				/* 27:24 Sync Flags */
+	uint32_t pipe:1;	/* Pipeline */
+	uint32_t longccb:1;	/* Longccb. Set for scan with lu2, lu3, lu4. */
+	uint32_t cond:1;	/* Conditional */
+	uint32_t serial:1;	/* Serial */
+	uint32_t opcode:8;	/* 23:16 Opcode */
+				/* 15:0 Address Type. */
+	uint32_t reserved:3;		/* 15:13 reserved */
+	uint32_t table_addr_type:2;	/* 12:11 Huffman Table Address Type */
+	uint32_t out_addr_type:3;	/* 10:8 Destination Address Type */
+	uint32_t sec_addr_type:3;	/* 7:5 Secondary Source Address Type */
+	uint32_t pri_addr_type:3;	/* 4:2 Primary Source Address Type */
+	uint32_t cca_addr_type:2;	/* 1:0 Completion Address Type */
+} dax_header_t;
+
+/* Generic Control Word, followed by opcode-specific Control Words */
+
+#define	DAX_CONTROL_COMMON	\
+	uint32_t pri_fmt:4;	  /* 31:28 Primary Input Format */	      \
+	uint32_t pri_elem_size:5; /* 27:23 Primary Input Element Size(less1) */\
+	uint32_t pri_offset:3;	  /* 22:20 Primary Input Starting Offset */   \
+	uint32_t sec_encoding:1;  /* 19    Secondary Input Encoding */	      \
+					/* (must be 0 for Select) */	      \
+	uint32_t sec_offset:3;	  /* 18:16 Secondary Input Starting Offset */ \
+	uint32_t sec_elem_size:2; /* 15:14 Secondary Input Element Size */    \
+					/* (must be 0 for Select) */	      \
+	uint32_t out_fmt:2;	  /* 13:12 Output Format */		      \
+	uint32_t out_elem_size:2; /* 11:10 Output Element Size */
+
+typedef struct {
+	DAX_CONTROL_COMMON	/* 31:10 */
+	uint32_t misc:10;
+} dax_control_t;
+
+typedef struct {
+	DAX_CONTROL_COMMON	/* 31:10 */
+	uint32_t u_size:5;  /* 9:5 U operand size, bytes less 1 (or disable) */
+	uint32_t l_size:5;  /* 4:0 L operand size, bytes less 1 (or disable) */
+} dax_scan_control_t;
+
+typedef struct {
+	DAX_CONTROL_COMMON	/* 31:10 */
+	uint32_t unused:1;	/* 9 Reserved */
+	uint32_t test_value:9;	/* 8:0 for v1; 7:0 for v2 with 8 unused */
+} dax_translate_control_t;
+
+typedef struct {
+	DAX_CONTROL_COMMON	/* 31:10 */
+	uint32_t pad_dir:1;	/* 9	 Padding Direction */
+	uint32_t unused:9;	/* 8:0	 Reserved, set to 0 */
+} dax_extract_control_t, dax_select_control_t;
+
+typedef struct {
+	uint32_t ext_opcode:1;	/* 31	 Extended Opcode: 0 nop, 1 sync */
+	uint32_t unused:31;	/* 30:0  Reserved, set to 0 */
+} dax_nop_control_t;
+
+typedef struct {
+	uint64_t flow_ctrl:2;		/* 63:62 Flow Control Type */
+	uint64_t pipe_target:2;		/* 61:60 Pipeline Target */
+	uint64_t out_buf_size:20;	/* 59:40 Output Buffer Size */
+					/*	 (cachelines less 1) */
+	uint64_t unused1:8;		/* 39:32 Reserved, Set to 0 */
+	uint64_t out_alloc:5;		/* 31:27 Output Allocation */
+	uint64_t unused2:1;		/* 26	 Reserved */
+	uint64_t pri_len_fmt:2;		/* 25:24 Input Length Format */
+	uint64_t pri_len:24;		/* 23:0  Input Element/Byte/Bit Count */
+					/*	 (less 1) */
+} dax_data_access_t;
+
+typedef struct {
+	uint32_t upper;		/* U operand MSW */
+	uint32_t lower;		/* L operand MSW */
+} dax_lu_t;
+
+/* Generic CCB, followed by opcode-specific CCBs */
+
+struct dax_ccb {
+	dax_header_t hdr;	/* CCB Header */
+	dax_control_t ctrl;	/* Control Word */
+	void *ca;		/* Completion Address */
+	void *pri;		/* Primary Input Address */
+	dax_data_access_t dac;	/* Data Access Control */
+	void *sec;		/* Secondary Input Address */
+	uint64_t dword5;	/* depends on opcode */
+	void *out;		/* Output Address */
+	void *huff_or_bitmap;	/* Huff Table Address or bitmap */
+};
+
+typedef struct {
+	dax_header_t hdr;	/* CCB Header */
+	dax_extract_control_t ctrl; /* Control Word */
+	void *ca;		/* Completion Address */
+	void *pri;		/* Primary Input Address */
+	dax_data_access_t dac;	/* Data Access Control */
+	void *sec;		/* Secondary Input Address */
+	uint64_t dword5;	/* Unused, must be 0 */
+	void *out;		/* Output Address  */
+	void *huff;		/* Huff Table Address */
+} dax_extract_ccb_t;
+
+typedef struct {
+	dax_header_t hdr;	/* CCB Header */
+	dax_translate_control_t ctrl; /* Control Word */
+	void *ca;		/* Completion Address */
+	void *pri;		/* Primary Input Address */
+	dax_data_access_t dac;	/* Data Access Control */
+	void *sec;		/* Secondary Input Address */
+	uint64_t dword5;	/* Unused, must be 0 */
+	void *out;		/* Output Address  */
+	void *bitmap;		/* Translate Vector Address */
+} dax_translate_ccb_t;
+
+typedef struct {
+	dax_header_t hdr;	/* CCB Header */
+	dax_select_control_t ctrl; /* Control Word */
+	void *ca;		/* Completion Address */
+	void *pri;		/* Primary Input Address */
+	dax_data_access_t dac;	/* Data Access Control */
+	void *sec;		/* Secondary Input Address */
+	uint64_t dword5;	/* Unused, must be 0 */
+	void *out;		/* Output Address  */
+	void *huff;		/* Huff Table Address */
+} dax_select_ccb_t;
+
+typedef struct {
+	dax_header_t hdr;	/* CCB Header */
+	dax_scan_control_t ctrl; /* Control Word */
+	void *ca;		/* Completion Address */
+	void *pri;		/* Primary Input Address */
+	dax_data_access_t dac;	/* Data Access Control */
+	void *sec;		/* Secondary Input Address */
+	dax_lu_t lu1;		/* L and U Operands MSW */
+	void *out;		/* Output Address  */
+	void *huff;		/* Huff Table Address */
+
+		/* note: must set longccb if these fields are used */
+	dax_lu_t lu2;		/* L and U operand 2MSW */
+	dax_lu_t lu3;		/* L and U operand 3MSW */
+	dax_lu_t lu4;		/* L and U operand 4MSW */
+	uint64_t unused[5];	/* Reserved, must be 0 */
+} dax_scan_ccb_t;
+
+typedef struct {
+	dax_header_t hdr;	/* CCB Header */
+	dax_nop_control_t ctrl;	/* Control Word */
+	void *ca;		/* Completion Address */
+	uint64_t unused[6];	/* Unused, must be 0 */
+} dax_nop_ccb_t, dax_sync_ccb_t;
+
+#define	OFFSETOF(s, m)	((size_t)(&(((s *)0)->m)))
+#define	CCB_LU1_OFFSET	OFFSETOF(dax_scan_ccb_t, lu1)
+#define	CCB_LU2_OFFSET	OFFSETOF(dax_scan_ccb_t, lu2)
+
+/* Dax command completion area */
+
+/* dax_cca_t cmd_status */
+#define	CCA_STAT_NOT_COMPLETED	0
+#define	CCA_STAT_COMPLETED	1
+#define	CCA_STAT_FAILED		2
+#define	CCA_STAT_KILLED		3
+#define	CCA_STAT_NOT_RUN	4
+#define	CCA_STAT_PIPE_OUT	5
+#define	CCA_STAT_PIPE_SRC	6
+#define	CCA_STAT_PIPE_DST	7
+
+#define	IS_CCA_COMPLETED(status)		\
+	(((status) = CCA_STAT_COMPLETED) |	\
+	((status) = CCA_STAT_PIPE_OUT))
+
+/* dax_cca_t err_mask */
+#define	CCA_ERR_SUCCESS		0x0	/* no error */
+#define	CCA_ERR_OVERFLOW	0x1	/* buffer overflow */
+#define	CCA_ERR_DECODE		0x2	/* CCB decode error */
+#define	CCA_ERR_PAGE_OVERFLOW	0x3	/* page overflow */
+#define	CCA_ERR_KILLED		0x7	/* command was killed */
+#define	CCA_ERR_TIMEOUT		0x8	/* Timeout */
+#define	CCA_ERR_ADI		0x9	/* ADI error */
+#define	CCA_ERR_DATA_FMT	0xA	/* data format error */
+#define	CCA_ERR_OTHER_NO_RETRY	0xE	/* Other error, do not retry */
+#define	CCA_ERR_OTHER_RETRY	0xF	/* Other error, retry */
+#define	CCA_ERR_PARTIAL_SYMBOL	0x80	/* QP partial symbol warning */
+
+/* These error codes are poked into err_mask by software, not used by dax */
+#define	CCA_ERR_NOT_RUN		0xf9	/* innocent ccb being skipped */
+#define	CCA_ERR_THREAD		0xfa	/* thread did not init dax */
+#define	CCA_ERR_SUBMIT		0xfb	/* unknown submission error */
+#define	CCA_ERR_EAGAIN		0xfc	/* try again */
+#define	CCA_ERR_NOMAP		0xfd	/* no VA->PA mapping for some arg */
+#define	CCA_ERR_NOACCESS	0xfe	/* no permission to access some arg */
+#define	CCA_ERR_UNAVAILABLE	0xff	/* dax unavailable during live migr */
+
+struct dax_cca {
+	uint8_t		status; 	/* user may mwait on this address */
+	uint8_t 	err;		/* user visible error notification */
+	uint8_t 	rsvd[2];	/* reserved */
+	uint32_t	n_remaining;	/* for QP partial symbol warning */
+	uint32_t	output_sz;	/* output in bytes */
+	uint32_t	rsvd2;		/* reserved */
+	uint64_t	run_cycles;	/* run time in OCND2 cycles */
+	uint64_t	run_stats;	/* nothing reported in version 1.0 */
+	uint32_t	n_processed;	/* number input elements */
+	uint32_t	rsvd3[5];	/* reserved */
+	uint64_t	retval; 	/* command return value */
+	uint64_t	rsvd4[8];	/* reserved */
+};
+
+typedef struct dax_cca dax_cca_t;
+
+/* Bitfield definitions for CCB Header */
+
+#define	HDR_DATATYPE			uint32_t
+
+#define	HDR_CCA_ADDR_TYPE_LOW		0
+#define	HDR_CCA_ADDR_TYPE_HIGH		1
+#define	HDR_CCA_ADDR_TYPE_DATATYPE	HDR_DATATYPE
+
+#define	HDR_PRI_ADDR_TYPE_LOW		2
+#define	HDR_PRI_ADDR_TYPE_HIGH		4
+#define	HDR_PRI_ADDR_TYPE_DATATYPE	HDR_DATATYPE
+
+#define	HDR_SEC_ADDR_TYPE_LOW		5
+#define	HDR_SEC_ADDR_TYPE_HIGH		7
+#define	HDR_SEC_ADDR_TYPE_DATATYPE	HDR_DATATYPE
+
+#define	HDR_OUT_ADDR_TYPE_LOW		8
+#define	HDR_OUT_ADDR_TYPE_HIGH		10
+#define	HDR_OUT_ADDR_TYPE_DATATYPE	HDR_DATATYPE
+
+#define	HDR_TABLE_ADDR_TYPE_LOW		11
+#define	HDR_TABLE_ADDR_TYPE_HIGH	12
+#define	HDR_TABLE_ADDR_TYPE_DATATYPE	HDR_DATATYPE
+
+#define	HDR_OPCODE_LOW			16
+#define	HDR_OPCODE_HIGH			23
+#define	HDR_OPCODE_DATATYPE		HDR_DATATYPE
+
+#define	HDR_SERIAL_LOW			24
+#define	HDR_SERIAL_HIGH			24
+#define	HDR_SERIAL_DATATYPE		HDR_DATATYPE
+
+#define	HDR_COND_LOW			25
+#define	HDR_COND_HIGH			25
+#define	HDR_COND_DATATYPE		HDR_DATATYPE
+
+#define	HDR_LONGCCB_LOW			26
+#define	HDR_LONGCCB_HIGH		26
+#define	HDR_LONGCCB_DATATYPE		HDR_DATATYPE
+
+#define	HDR_PIPE_LOW			27
+#define	HDR_PIPE_HIGH			27
+#define	HDR_PIPE_DATATYPE		HDR_DATATYPE
+
+#define	HDR_SYNC_FLAGS_LOW		24
+#define	HDR_SYNC_FLAGS_HIGH		27
+#define	HDR_SYNC_FLAGS_DATATYPE		HDR_DATATYPE
+
+#define	HDR_CCB_VERSION_LOW		28
+#define	HDR_CCB_VERSION_HIGH		31
+#define	HDR_CCB_VERSION_DATATYPE	HDR_DATATYPE
+
+/*
+ * Bitfield definitions for CCB Control Word: dax_extract_control_t,
+ * dax_scan_control_t, dax_translate_control_t, dax_select_control_t,
+ * dax_nop_control_t.
+ */
+
+#define	CTRL_DATATYPE			uint32_t
+
+/* For Extract, Scan, Translate, Select */
+#define	CTRL_OUT_ELEM_SIZE_LOW		10
+#define	CTRL_OUT_ELEM_SIZE_HIGH		11
+#define	CTRL_OUT_ELEM_SIZE_DATATYPE	CTRL_DATATYPE
+
+#define	CTRL_OUT_FMT_LOW		12
+#define	CTRL_OUT_FMT_HIGH		13
+#define	CTRL_OUT_FMT_DATATYPE		CTRL_DATATYPE
+
+#define	CTRL_SEC_ELEM_SIZE_LOW		14
+#define	CTRL_SEC_ELEM_SIZE_HIGH		15
+#define	CTRL_SEC_ELEM_SIZE_DATATYPE	CTRL_DATATYPE
+
+#define	CTRL_SEC_OFFSET_LOW		16
+#define	CTRL_SEC_OFFSET_HIGH		18
+#define	CTRL_SEC_OFFSET_DATATYPE	CTRL_DATATYPE
+
+#define	CTRL_SEC_ENCODING_LOW		19
+#define	CTRL_SEC_ENCODING_HIGH		19
+#define	CTRL_SEC_ENCODING_DATATYPE	CTRL_DATATYPE
+
+#define	CTRL_PRI_OFFSET_LOW		20
+#define	CTRL_PRI_OFFSET_HIGH		22
+#define	CTRL_PRI_OFFSET_DATATYPE	CTRL_DATATYPE
+
+#define	CTRL_PRI_ELEM_SIZE_LOW		23
+#define	CTRL_PRI_ELEM_SIZE_HIGH		27
+#define	CTRL_PRI_ELEM_SIZE_DATATYPE	CTRL_DATATYPE
+
+#define	CTRL_PRI_FMT_LOW		28
+#define	CTRL_PRI_FMT_HIGH		31
+#define	CTRL_PRI_FMT_DATATYPE		CTRL_DATATYPE
+
+/* For Sync and No-op */
+#define	CTRL_OPCODE_LOW			31
+#define	CTRL_OPCODE_HIGH		31
+#define	CTRL_OPCODE_DATATYPE		CTRL_DATATYPE
+
+/* For Extract and Select */
+#define	CTRL_PAD_DIR_LOW		9
+#define	CTRL_PAD_DIR_HIGH		9
+#define	CTRL_PAD_DIR_DATATYPE		CTRL_DATATYPE
+
+/* For Scan */
+#define	CTRL_L_SIZE_LOW			0
+#define	CTRL_L_SIZE_HIGH		4
+#define	CTRL_L_SIZE_DATATYPE		CTRL_DATATYPE
+
+#define	CTRL_U_SIZE_LOW			5
+#define	CTRL_U_SIZE_HIGH		9
+#define	CTRL_U_SIZE_DATATYPE		CTRL_DATATYPE
+
+/* Bitfield definitions for Data Access Control, dax_data_access_t */
+
+#define	DAC_DATATYPE			uint64_t
+
+#define	DAC_PRI_LEN_LOW			0
+#define	DAC_PRI_LEN_HIGH		23
+#define	DAC_PRI_LEN_DATATYPE		DAC_DATATYPE
+
+#define	DAC_PRI_LEN_FMT_LOW		24
+#define	DAC_PRI_LEN_FMT_HIGH		25
+#define	DAC_PRI_LEN_FMT_DATATYPE	DAC_DATATYPE
+
+#define	DAC_OUT_ALLOC_LOW		27
+#define	DAC_OUT_ALLOC_HIGH		31
+#define	DAC_OUT_ALLOC_DATATYPE		DAC_DATATYPE
+
+#define	DAC_OUT_BUF_SIZE_LOW		40
+#define	DAC_OUT_BUF_SIZE_HIGH		59
+#define	DAC_OUT_BUF_SIZE_DATATYPE	DAC_DATATYPE
+
+#define	DAC_PIPE_TARGET_LOW		60
+#define	DAC_PIPE_TARGET_HIGH		61
+#define	DAC_PIPE_TARGET_DATATYPE	DAC_DATATYPE
+
+#define	DAC_FLOW_CTRL_LOW		62
+#define	DAC_FLOW_CTRL_HIGH		63
+#define	DAC_FLOW_CTRL_DATATYPE		DAC_DATATYPE
+
+#define	SHORT_CCB_UNITS			1
+#define	LONG_CCB_UNITS			2
+#define	CCB_MAX_SIZE			(LONG_CCB_UNITS * sizeof (dax_ccb_t))
+#define	CCB_MIN_SIZE			sizeof (dax_ccb_t)
+#define	CCB_UNIT_SIZE			sizeof (dax_ccb_t)
+#define	CCA_SIZE			sizeof (dax_cca_t)
+#define	CCA_UNIT_SIZE			sizeof (dax_cca_t)
+
+/* TBD: delete if unused */
+#define	CCB_CONT		0
+
+#define	IS_LONG_CCB(ccb)	\
+	((*((uint64_t *)(ccb)) >> (32 + DAX_LONGCCB_SHIFT)) & 0x1)
+
+#define	IS_PIPE_CCB(ccb)	\
+	((*((uint64_t *)(ccb)) >> (32 + DAX_PIPECCB_SHIFT)) & 0x1)
+
+#define	CCB_ENTRIES(ccb)	\
+	(1 << IS_LONG_CCB(ccb))
+
+#define	CCB_SIZE(ccb)		\
+	(CCB_MIN_SIZE << IS_LONG_CCB(ccb))
+
+#define	MAX_BIT_WIDTH_32KBITS_TRANS_VEC 15
+
+#endif	/* _DAX1_CCB_H */
diff --git a/Documentation/sparc/oradax/extract_example.c b/Documentation/sparc/oradax/extract_example.c
new file mode 100644
index 0000000..0916a7b
--- /dev/null
+++ b/Documentation/sparc/oradax/extract_example.c
@@ -0,0 +1,219 @@
+/*
+** Example
+**
+** Copyright © 2017 Oracle corp.  All rights reserved.
+** The Universal Permissive License (UPL), Version 1.0
+**
+** Subject to the condition set forth below, permission is hereby granted to any person obtaining a copy of this
+** software, associated documentation and/or data (collectively the "Software"), free of charge and under any and
+** all copyright rights in the Software, and any and all patent rights owned or freely licensable by each licensor
+** hereunder covering either (i) the unmodified Software as contributed to or provided by such licensor, or
+** (ii) the Larger Works (as defined below), to deal in both
+**
+** (a) the Software, and
+** (b) any piece of software and/or hardware listed in the lrgrwrks.txt file if one is included with the Software
+** (each a “Larger Work” to which the Software is contributed by such licensors),
+**
+** without restriction, including without limitation the rights to copy, create derivative works of, display,
+** perform, and distribute the Software and make, use, sell, offer for sale, import, export, have made, and have
+** sold the Software and the Larger Work(s), and to sublicense the foregoing rights on either these or other terms.
+**
+** This license is subject to the following condition:
+** The above copyright notice and either this complete permission notice or at a minimum a reference to the UPL must
+** be included in all copies or substantial portions of the Software.
+**
+** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
+** THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
+** CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+** IN THE SOFTWARE.
+*/
+
+/*
+ * This is example code to demonstrate how any kernel code
+ * can utilize the Oracle DAX coprocessor.
+ *
+ * This particular example implements a simple memory clearing
+ * function using the coprocessor's Extract operation.
+ */
+
+#include <linux/slab.h>
+#include <asm/hypervisor.h>
+#include "dax1_ccb.h"
+
+#define ASI_MONITOR_PRIMARY 0x84
+u8 loadmon8(void *addr)
+{
+	u8 ret;
+
+	__asm__ __volatile__("lduba [%[src]] %[asi], %[dest]\n"
+			     : [dest] "=r" (ret)
+			     : [asi] "i" (ASI_MONITOR_PRIMARY),
+			       [src] "r" (addr));
+	return ret;
+}
+
+#define MWAIT_COUNT_REGISTER 28
+void mwait(int nsecs)
+{
+	__asm__ __volatile__("wr %%g0, %[arg], %%asr%[mcr]\n"
+			     : : [arg] "r" (nsecs),
+			       [mcr] "i" (MWAIT_COUNT_REGISTER));
+}
+
+/*
+ * DAX Extract operation to zero the output buffer.
+ *
+ * The primary input buffer is a page full of zeroes, and the
+ * secondary input buffer is a run-length-encoding, where byte I
+ * determines the number of copies of primary input byte I to be
+ * produced in the output. We fill the RLE buffer with the value 0xff,
+ * which produces 256 copies of each input byte in the output.
+ * Additionally, the output format is specified as 16 bytes, so each
+ * byte of input produces 16 bytes of output. Thus each 1-byte element
+ * is expanded to a 16B output elem, 256 times (16 * 256 = 4096), and
+ * with an 8k page of inputs, we can clear 32Mb (4k*8k) of memory.
+ */
+#define	DAX_RLE_EXPAND_ELEM_LEN (16*256UL)
+#define	DAX_ZERO_OUTPUT_MAX_LEN (DAX_RLE_EXPAND_ELEM_LEN * PAGE_SIZE)
+#define	DAX_ZERO_TIMEOUT (5UL * 1000UL * 1000UL * 1000UL)
+#define MWAIT_TIME 8192
+
+int dax_zero(void *addr, int len)
+{
+	unsigned long hv_rv, accepted_len, status_data, timeout, res;
+	struct dax_ccb *ccb;
+	struct dax_cca *cca;
+	void *src0, *src1;
+	u16 kill_res;
+	int ret = 1;
+
+	printk(KERN_ALERT "%s(%p, %x)\n", __func__, addr, len);
+
+	if (len > DAX_ZERO_OUTPUT_MAX_LEN)
+		return ret;
+
+	ccb = kzalloc(sizeof(*ccb), GFP_KERNEL); /* command block */
+	cca = kzalloc(sizeof(*cca), GFP_KERNEL); /* completion area */
+	src0 = kzalloc(2 * PAGE_SIZE, GFP_KERNEL); /* primary input */
+	src1 = src0 + PAGE_SIZE;		   /* secondary input */
+	memset(src1, 0xff, PAGE_SIZE);
+
+	ccb->hdr.opcode = DAX_OP_EXTRACT;
+
+	ccb->hdr.pri_addr_type = DAX_ADDR_TYPE_VA;
+	ccb->hdr.sec_addr_type = DAX_ADDR_TYPE_VA;
+	ccb->hdr.out_addr_type = DAX_ADDR_TYPE_VA;
+	ccb->hdr.cca_addr_type = DAX_ADDR_TYPE_VA;
+
+	ccb->pri = src0;
+	ccb->sec = src1;
+	ccb->out = addr;
+	ccb->ca = cca;
+
+	ccb->ctrl.pri_fmt = DAX_PRI_FMT_RLE;
+	ccb->ctrl.pri_elem_size = DAX_PRI_ELEM_SIZE(1);
+	ccb->ctrl.sec_encoding = DAX_SEC_ENCODING_LESS1;
+	ccb->ctrl.sec_elem_size = DAX_SEC_ELEM_SIZE(8);
+	ccb->ctrl.out_fmt = DAX_OUT_FMT_16B;
+	ccb->ctrl.out_elem_size = 0;
+
+	ccb->dac.pri_len_fmt = DAX_PRI_LEN_FMT_BYTES;
+	ccb->dac.pri_len = DAX_PRI_LEN(len / DAX_RLE_EXPAND_ELEM_LEN);
+	ccb->dac.out_buf_size = DAX_OUT_BUF_SIZE(len);
+
+	hv_rv = sun4v_ccb_submit((unsigned long)ccb, sizeof(*ccb),
+				 HV_CCB_ARG0_PRIVILEGED | HV_CCB_VA_PRIVILEGED |
+				 HV_CCB_ARG0_TYPE_PRIMARY | HV_CCB_QUERY_CMD,
+				 0, &accepted_len, &status_data);
+
+	if (hv_rv != HV_EOK || accepted_len != sizeof(*ccb)) {
+		printk(KERN_ALERT "ccb_submit failed (rv=%ld, status_data=0x%lx)\n",
+		       hv_rv, status_data);
+		goto done;
+	}
+
+	/*
+	 * handle any residual bytes here in parallel with the
+	 * coprocessor
+	 */
+	res = len % DAX_RLE_EXPAND_ELEM_LEN;
+	memset(addr + (len - res), 0, res);
+
+	for (timeout = DAX_ZERO_TIMEOUT; timeout > 0; timeout -= MWAIT_TIME) {
+		if (loadmon8(cca) = CCA_STAT_NOT_COMPLETED)
+			mwait(MWAIT_TIME);
+		else
+			break;
+	}
+
+	if (cca->status = CCA_STAT_COMPLETED) {
+		ret = 0;
+		goto done;
+	} else if (cca->status = CCA_STAT_NOT_COMPLETED) {
+		printk(KERN_ALERT "dax_zero ccb timed out, kill ccb\n");
+		hv_rv = sun4v_ccb_kill(virt_to_phys(cca), &kill_res);
+		if (hv_rv = HV_EOK) {
+			printk(KERN_ALERT "ccb kill successful (kill_res=%d)\n",
+			       kill_res);
+		} else {
+			printk(KERN_ALERT "ccb kill failed (hv_rv=%ld)\n",
+			       hv_rv);
+		}
+
+	} else {
+		printk(KERN_ALERT "ccb failed, status=%d, err=0x%x\n",
+		       cca->status, cca->err);
+	}
+
+done:
+	kfree(src0);
+	kfree(cca);
+	kfree(ccb);
+	return ret;
+}
+
+#if 0
+void test_dax_zero(void)
+{
+	u8 *output;
+	long i, j;
+	long sizes[] = {8192, 8192 + 653, 16384, 4 * 1024 * 1024,
+			DAX_ZERO_OUTPUT_MAX_LEN};
+
+	output = kzalloc(DAX_ZERO_OUTPUT_MAX_LEN, GFP_KERNEL);
+	if (output = NULL)
+		return;
+
+	for (j = 0; j < sizeof(sizes) / sizeof(long); j++) {
+		long size = sizes[j];
+
+		/* set output to 0xaa */
+		memset(output, 0xaa, DAX_ZERO_OUTPUT_MAX_LEN);
+
+		dax_zero(output, size);
+
+		/* check that all bytes zeroed are 0, and all others are 0xaa */
+		for (i = 0; i < size; i++) {
+			if (output[i] != 0) {
+				printk(KERN_ALERT "dax_zero test (size=%ld) fail: output[%ld]=%x (expected 0)\n",
+				       size, i, output[i]);
+				goto done;
+			}
+		}
+
+		for (i = size; i < DAX_ZERO_OUTPUT_MAX_LEN; i++) {
+			if (output[i] != 0xaa) {
+				printk(KERN_ALERT "dax_zero test (size=%ld) fail: output[%ld]=%x (expected 0xaa)\n",
+				       size, i, output[i]);
+				goto done;
+			}
+		}
+	}
+
+	printk(KERN_ALERT "dax_zero test passed, all bytes correct\n");
+
+done:
+	kfree(output);
+}
+#endif
diff --git a/Documentation/sparc/oradax/oracle_dax.txt b/Documentation/sparc/oradax/oracle_dax.txt
new file mode 100644
index 0000000..96d373a
--- /dev/null
+++ b/Documentation/sparc/oradax/oracle_dax.txt
@@ -0,0 +1,249 @@
+Oracle Data Analytics Accelerator (DAX)
+---------------------------------------
+
+DAX is a coprocessor which resides on the SPARC M7 (DAX1) and M8
+(DAX2) processor chips, and has direct access to the CPU's L3 caches
+as well as physical memory. It can perform several operations on data
+streams with various input and output formats.  A driver provides a
+transport mechanism and has limited knowledge of the various opcodes
+and data formats. A user space library provides high level services
+and translates these into low level commands which are then passed
+into the driver and subsequently the Hypervisor and the coprocessor.
+The library is the recommended way for applications to use the
+coprocessor, and the driver interface is not intended for general use.
+This document describes the general flow of the driver, its
+structures, and its programmatic interface.
+
+The user library is open source and available at:
+    https://oss.oracle.com/git/gitweb.cgi?p=libdax.git
+
+The Hypervisor interface to the coprocessor is described in detail in
+the accompanying document, dax-hv-api.txt, which is a plain text
+excerpt of the (Oracle internal) "UltraSPARC Virtual Machine
+Specification" version 3.0.20, dated 2017-04-05.
+
+
+High Level Overview
+-------------------
+
+A coprocessor request is described by a Command Control Block
+(CCB). The CCB contains an opcode and various parameters. The opcode
+specifies what operation is to be done, and the parameters specify
+options, flags, sizes, and addresses.  The CCB (or an array of CCBs)
+is passed to the Hypervisor, which handles queueing and scheduling of
+requests to the available coprocessor execution units. A status code
+returned indicates if the request was submitted successfully or if
+there was an error.  One of the addresses given in each CCB is a
+pointer to a "completion area", which is a 128 byte memory block that
+is written by the coprocessor to provide execution status. No
+interrupt is generated upon completion; the completion area must be
+polled by software to find out when a transaction has finished, but
+the M7 and later processors provide a mechanism to pause the virtual
+processor until the completion status has been updated by the
+coprocessor. This is done using the monitored load and mwait
+instructions, which are described in more detail later.  The DAX
+coprocessor was designed so that after a request is submitted, the
+kernel is no longer involved in the processing of it.  The polling is
+done at the user level, which results in almost zero latency between
+completion of a request and resumption of execution of the requesting
+thread.
+
+
+Addressing Memory
+-----------------
+
+The kernel does not have access to physical memory in the Sun4v
+architecture, as there is an additional level of memory virtualization
+present. This intermediate level is called "real" memory, and the
+kernel treats this as if it were physical.  The Hypervisor handles the
+translations between real memory and physical so that each logical
+domain (LDOM) can have a partition of physical memory that is isolated
+from that of other LDOMs.  When the kernel sets up a virtual mapping,
+it specifies a virtual address and the real address to which it should
+be mapped.
+
+The DAX coprocessor can only operate on physical memory, so before a
+request can be fed to the coprocessor, all the addresses in a CCB must
+be converted into physical addresses. The kernel cannot do this since
+it has no visibility into physical addresses. So a CCB may contain
+either the virtual or real addresses of the buffers or a combination
+of them. An "address type" field is available for each address that
+may be given in the CCB. In all cases, the Hypervisor will translate
+all the addresses to physical before dispatching to hardware. Address
+translations are performed using the context of the process initiating
+the request.
+
+
+The Driver API
+--------------
+
+An application makes requests to the driver via the write() system
+call, and gets results (if any) via read(). The completion areas are
+made accessible via mmap(), and are read-only for the application.
+
+The request may either be an immediate command or an array of CCBs to
+be submitted to the hardware.
+
+Each open instance of the device is exclusive to the thread that
+opened it, and must be used by that thread for all subsequent
+operations. The driver open function creates a new context for the
+thread and initializes it for use.  This context contains pointers and
+values used internally by the driver to keep track of submitted
+requests. The completion area buffer is also allocated, and this is
+large enough to contain the completion areas for many concurrent
+requests.  When the device is closed, any outstanding transactions are
+flushed and the context is cleaned up.
+
+On a DAX1 system (M7), the device will be called "oradax1", while on a
+DAX2 system (M8) it will be "oradax2". If an application requires one
+or the other, it should simply attempt to open the appropriate
+device. Only one of the devices will exist on any given system, so the
+name can be used to determine what the platform supports.
+
+The immediate commands are CCB_DEQUEUE, CCB_KILL, and CCB_INFO. For
+all of these, success is indicated by a return value from write()
+equal to the number of bytes given in the call. Otherwise -1 is
+returned and errno is set.
+
+CCB_DEQUEUE
+
+Tells the driver to clean up resources associated with past
+requests. Since no interrupt is generated upon the completion of a
+request, the driver must be told when it may reclaim resources.  No
+further status information is returned, so the user should not
+subsequently call read().
+
+CCB_KILL
+
+Kills a CCB during execution. The CCB is guaranteed to not continue
+executing once this call returns successfully. On success, read() must
+be called to retrieve the result of the action.
+
+CCB_INFO
+
+Retrieves information about a currently executing CCB. Note that some
+Hypervisors might return 'notfound' when the CCB is in 'inprogress'
+state. To ensure a CCB in the 'notfound' state will never be executed,
+CCB_KILL must be invoked on that CCB. Upon success, read() must be
+called to retrieve the details of the action.
+
+Submission of an array of CCBs for execution
+
+A write() whose length is a multiple of the CCB size is treated as a
+submit operation. The file offset is treated as the index of the
+completion area to use, and may be set via lseek() or using the
+pwrite() system call. If -1 is returned then errno is set to indicate
+the error. Otherwise, the return value is the length of the array that
+was actually accepted by the coprocessor. If the accepted length is
+equal to the requested length, then the operation was completely
+successful and there is no further status needed; hence, the user
+should not subsequently call read(). Partial acceptance of the CCB
+array is indicated by a return value less than the requested length,
+and read() must be called to retrieve further status information.  The
+status will reflect the error caused by the first CCB that was not
+accepted, and status_data will provide additional data in some cases.
+
+MMAP
+
+The mmap() function provides access to the completion area allocated
+in the driver.  Note that the completion area is not writeable by the
+user process.
+
+
+Completion of a Request
+-----------------------
+
+The first byte in each completion area is the command status which is
+updated by the coprocessor hardware. Software may take advantage of
+new M7/M8 processor capabilities to efficiently poll this status byte.
+First, a "monitored load" is achieved via a Load from Alternate Space
+(ldxa, lduba, etc.) with ASI 0x84 (ASI_MONITOR_PRIMARY).  Second, a
+"monitored wait" is achieved via the mwait instruction. This
+instruction is like pause in that it suspends execution of the virtual
+processor, but in addition will terminate early when one of several
+events occur. If the block of data containing the monitored location
+is modified, then the mwait terminates. This allows software to resume
+execution immediately (without a context switch or kernel to user
+transition) after a transaction completes. Thus the latency between
+transaction completion and resumption of execution may be just a few
+nanoseconds.
+
+
+Application Life Cycle of a DAX Submission
+------------------------------------------
+
+ - open dax device
+ - call mmap() to get the completion area address
+ - allocate a CCB and fill in the opcode, flags, parameter, addresses, etc.
+ - submit CCB via write() or pwrite()
+ - go into a loop executing monitored load + monitored wait and
+   terminate when the command status indicates the request is complete
+   (CCB_KILL or CCB_INFO may be used any time as necessary)
+ - perform a CCB_DEQUEUE
+ - call munmap() for completion area
+ - close the dax device
+
+
+Memory Constraints
+------------------
+
+The DAX hardware operates only on physical addresses. Therefore, it is
+not aware of virtual memory mappings and the discontiguities that may
+exist in the physical memory that a virtual buffer maps to. There is
+no I/O TLB or any scatter/gather mechanism. All buffers, whether input
+or output, must reside in a physically contiguous region of memory.
+
+The Hypervisor translates all addresses within a CCB to physical
+before handing off the CCB to DAX. The Hypervisor determines the
+virtual page size for each virtual address given, and uses this to
+program a size limit for each address. This prevents the coprocessor
+from reading or writing beyond the bound of the virtual page, even
+though it is accessing physical memory directly. A simpler way of
+saying this is that a DAX operation will never "cross" a virtual page
+boundary. If an 8k virtual page is used, then the data is strictly
+limited to 8k. If a user's buffer is larger than 8k, then a larger
+page size must be used, or the transaction size will be truncated to
+8k.
+
+Huge pages. A user may allocate huge pages using standard
+interfaces. Memory buffers residing on huge pages may be used to
+achieve much larger DAX transaction sizes, but the rules must still be
+followed, and no transaction will cross a page boundary, even a huge
+page.  A major caveat is that Linux on Sparc presents 8Mb as one of
+the huge page sizes. Sparc does not actually provide a 8Mb hardware
+page size, and this size is synthesized by pasting together two 4Mb
+pages. The reasons for this are historical, and it creates an issue
+because only half of this 8Mb page can actually be used for any given
+buffer in a DAX request, and it must be either the first half or the
+second half; it cannot be a 4Mb chunk in the middle, since that
+crosses a (hardware) page boundary. Note that this entire issue may be
+hidden by higher level libraries.
+
+
+CCB Structure
+-------------
+A CCB is an array of 8 64-bit words. Several of these words provide
+command opcodes, parameters, flags, etc., and the rest are addresses
+for the completion area, output buffer, and various inputs:
+
+   struct ccb {
+       u64   control;
+       u64   completion;
+       u64   input0;
+       u64   access;
+       u64   input1;
+       u64   rsvd;
+       u64   output;
+       u64   table;
+   };
+
+See libdax/common/sys/dax1/dax1_ccb.h for a detailed description of
+each of these fields, and see dax-hv-api.txt for a complete description
+of the Hypervisor API available to the guest OS (ie, Linux kernel.)
+
+The first word (control) is examined by the driver for the following:
+ - CCB version, which must be consistent with hardware version
+ - Opcode, which must be one of the documented allowable commands
+ - Address types, which must be set to "virtual" for all the addresses
+   given by the user, thereby ensuring that the application can
+   only access memory that it owns
diff --git a/Documentation/sparc/oradax/scan_example.c b/Documentation/sparc/oradax/scan_example.c
new file mode 100644
index 0000000..707f6b3
--- /dev/null
+++ b/Documentation/sparc/oradax/scan_example.c
@@ -0,0 +1,214 @@
+/*
+** Example (from libdax/test)
+**
+** Copyright © 2017 Oracle corp.  All rights reserved.
+** The Universal Permissive License (UPL), Version 1.0
+**
+** Subject to the condition set forth below, permission is hereby granted to any person obtaining a copy of this
+** software, associated documentation and/or data (collectively the "Software"), free of charge and under any and
+** all copyright rights in the Software, and any and all patent rights owned or freely licensable by each licensor
+** hereunder covering either (i) the unmodified Software as contributed to or provided by such licensor, or
+** (ii) the Larger Works (as defined below), to deal in both
+**
+** (a) the Software, and
+** (b) any piece of software and/or hardware listed in the lrgrwrks.txt file if one is included with the Software
+** (each a “Larger Work” to which the Software is contributed by such licensors),
+**
+** without restriction, including without limitation the rights to copy, create derivative works of, display,
+** perform, and distribute the Software and make, use, sell, offer for sale, import, export, have made, and have
+** sold the Software and the Larger Work(s), and to sublicense the foregoing rights on either these or other terms.
+**
+** This license is subject to the following condition:
+** The above copyright notice and either this complete permission notice or at a minimum a reference to the UPL must
+** be included in all copies or substantial portions of the Software.
+**
+** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
+** THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
+** CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+** IN THE SOFTWARE.
+*/
+
+/*
+ * Program to demonstrate the interface to the driver
+ *
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "dax1_ccb.h"
+#include "../../arch/sparc/include/uapi/asm/oradax.h"
+
+void verify_bits(unsigned char *bitmap, int nbytes, int nbits)
+{
+	int i;
+
+	for (i=0; i<nbits; i++)
+		if ((bitmap[i/8] & (0x80 >> (i % 8))) = 0)
+			printf("bit %d is 0, expected 1, bitmap[%d]=0x%x\n",
+			       i, i/8, bitmap[i/8]);
+	for (i=nbits; i <nbytes*8; i++)
+		if ((bitmap[i/8] & (0x80 >> (i % 8))))
+			printf("bit %d is 1, expected 0, bitmap[%d]=0x%x\n",
+			       i, i/8, bitmap[i/8]);
+}
+
+#define ASI_MONITOR_PRIMARY 0x84
+uint8_t __attribute__((noinline)) loadmon8(void *addr)
+{
+	uint8_t ret;
+
+	__asm__ __volatile__("lduba [%[src]] %[asi], %[dest]\n"
+			     : [dest] "=r" (ret)
+			     : [asi] "i" (ASI_MONITOR_PRIMARY), [src] "r" (addr));
+	return ret;
+}
+
+#define MWAIT_COUNT_REGISTER 28
+void __attribute__((noinline)) mwait(int nsecs)
+{
+	__asm__ __volatile__("wr %%g0, %[arg], %%asr%[mcr]\n"
+			     : : [arg] "r" (nsecs), [mcr] "i" (MWAIT_COUNT_REGISTER));
+}
+
+/*
+ * SCAN operation: examine each element of a vector looking for those
+ * that match either of two values. The output is a bitmap which contains
+ * one bit for each input element. For each input element that matches
+ * either of the scan values, the corresponding output bit will be set
+ * to 1.
+ *
+ * Values to use for this scan:
+ *  should match 499 elements that match 0x77,
+ *  and 1001 elements that match 0xf5
+ */
+#define SCAN_VAL1 0x77
+#define SCAN_VAL2 0xf5
+
+#define SCAN_COUNT1 499
+#define SCAN_COUNT2 1001
+
+int main(void)
+{
+	char *dev;
+	int fd, ret;
+	dax_cca_t *ca;
+	dax_scan_ccb_t ccb;
+	struct dax_command dc;
+	struct ccb_exec_result res;
+	unsigned char *input, *output;
+
+	dev = "/dev/" DAX_NAME "1";
+	if (access(dev, F_OK) = -1) {
+		dev = "/dev/" DAX_NAME "2";
+		if (access(dev, F_OK) = -1) {
+			fprintf(stderr, "No dax device available\n");
+			exit(1);
+		}
+	}
+
+	fd = open(dev, O_RDWR);
+	if (fd < 0) {
+		perror(dev);
+		exit(1);
+	}
+
+	/* map completion area */
+	ca = mmap(NULL, DAX_MMAP_LEN, PROT_READ, MAP_SHARED, fd, 0);
+	if (ca = MAP_FAILED) {
+		perror("mmap");
+		exit(2);
+	}
+
+	/* allocate and initialize input buffer */
+	input = mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, 0, 0);
+	if (input = MAP_FAILED) {
+		perror("mmap input");
+		exit(4);
+	}
+	memset(input, 0, 8192);
+	memset(input, SCAN_VAL1, SCAN_COUNT1);
+	memset(input+SCAN_COUNT1, SCAN_VAL2, SCAN_COUNT2);
+
+	/* allocate and initialize output buffer */
+	output = mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, 0, 0);
+	if (output = MAP_FAILED) {
+		perror("mmap output");
+		exit(4);
+	}
+	memset(output, 0, 8192);
+
+	/* set up ccb for a SCAN operation */
+	memset(&ccb, 0, sizeof(dax_scan_ccb_t));
+	ccb.hdr.opcode = DAX_OP_SCAN_VALUE;
+
+	/* set source address, type, length, and format */
+	ccb.pri = input;
+	ccb.hdr.pri_addr_type = DAX_ADDR_TYPE_VA;
+	ccb.ctrl.pri_fmt = 0;	/* fixed width, byte */
+	ccb.ctrl.pri_elem_size = DAX_PRI_ELEM_SIZE(1);
+	ccb.dac.pri_len_fmt = DAX_PRI_LEN_FMT_BYTES;
+	ccb.dac.pri_len = DAX_LESS1(8192);
+
+	/* set output address, type, length, and format */
+	ccb.out = output;
+	ccb.hdr.out_addr_type = DAX_ADDR_TYPE_VA;
+	ccb.ctrl.out_fmt = DAX_OUT_FMT_BIT;
+	ccb.ctrl.out_elem_size = DAX_OUT_ELEM_SIZE(1);
+	ccb.dac.out_buf_size = DAX_OUT_BUF_SIZE(8192);
+
+	/* set scan values and sizes */
+	ccb.ctrl.u_size = DAX_LU_SIZE(1);
+	ccb.ctrl.l_size = DAX_LU_SIZE(1);
+	ccb.lu1.upper = SCAN_VAL1 << 24;
+	ccb.lu1.lower = SCAN_VAL2 << 24;
+
+	/* send ccb to coprocessor */
+	ret = write(fd, &ccb, 64);
+	if (ret != 64) {
+		/* submission failed, get driver status */
+		printf("write returned %d\n", ret);
+		if (read(fd, &res, sizeof(res)) != sizeof(res)) {
+			perror("read ccb exec error status");
+			exit(3);
+		}
+		printf("res.status = 0x%x, status_data = 0x%llx\n",
+		       res.status, res.status_data);
+		printf("input=%p, output=%p\n", input, output);
+
+		exit(3);
+	}
+
+	/* submission successful, poll completion area until done */
+	while (loadmon8(ca) = CCA_STAT_NOT_COMPLETED)
+		mwait(1000);
+
+	if (IS_CCA_COMPLETED(ca->status)) {
+		printf("Success, output size = %d, retval = %ld\n",
+		       ca->output_sz, ca->retval);
+		if (ca->retval != SCAN_COUNT1 + SCAN_COUNT2)
+			printf("retval doesn't match %d+%d\n",
+			       SCAN_COUNT1, SCAN_COUNT2);
+		verify_bits(output, 8192, SCAN_COUNT1 + SCAN_COUNT2);
+	} else {
+		printf("cmd_status = %d\n", ca->status);
+		printf("Failed, err=0x%x\n", ca->err);
+	}
+
+	/* dequeue */
+	dc.command = CCB_DEQUEUE;
+	if (write(fd, &dc, sizeof(dc)) != sizeof(dc))
+		perror("dequeue");
+
+	/* unmap completion area */
+	munmap(ca, DAX_MMAP_LEN);
+
+	close(fd);
+	return 0;
+}
+
diff --git a/arch/sparc/include/uapi/asm/oradax.h b/arch/sparc/include/uapi/asm/oradax.h
new file mode 100644
index 0000000..7229519
--- /dev/null
+++ b/arch/sparc/include/uapi/asm/oradax.h
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Oracle DAX driver API definitions
+ */
+
+#ifndef _ORADAX_H
+#define	_ORADAX_H
+
+#include <linux/types.h>
+
+#define	CCB_KILL 0
+#define	CCB_INFO 1
+#define	CCB_DEQUEUE 2
+
+struct dax_command {
+	__u16 command;		/* CCB_KILL/INFO/DEQUEUE */
+	__u16 ca_offset;	/* offset into mmapped completion area */
+};
+
+struct ccb_kill_result {
+	__u16 action;		/* action taken to kill ccb */
+};
+
+struct ccb_info_result {
+	__u16 state;		/* state of enqueued ccb */
+	__u16 inst_num;		/* dax instance number of enqueued ccb */
+	__u16 q_num;		/* queue number of enqueued ccb */
+	__u16 q_pos;		/* ccb position in queue */
+};
+
+struct ccb_exec_result {
+	__u64	status_data;	/* additional status data (e.g. bad VA) */
+	__u32	status;		/* one of DAX_SUBMIT_* */
+};
+
+union ccb_result {
+	struct ccb_exec_result exec;
+	struct ccb_info_result info;
+	struct ccb_kill_result kill;
+};
+
+#define	DAX_MMAP_LEN		(16 * 1024)
+#define	DAX_MAX_CCBS		15
+#define	DAX_CCB_BUF_MAXLEN	(DAX_MAX_CCBS * 64)
+#define	DAX_NAME		"oradax"
+
+/* CCB_EXEC status */
+#define	DAX_SUBMIT_OK			0
+#define	DAX_SUBMIT_ERR_RETRY		1
+#define	DAX_SUBMIT_ERR_WOULDBLOCK	2
+#define	DAX_SUBMIT_ERR_BUSY		3
+#define	DAX_SUBMIT_ERR_THR_INIT		4
+#define	DAX_SUBMIT_ERR_ARG_INVAL	5
+#define	DAX_SUBMIT_ERR_CCB_INVAL	6
+#define	DAX_SUBMIT_ERR_NO_CA_AVAIL	7
+#define	DAX_SUBMIT_ERR_CCB_ARR_MMU_MISS	8
+#define	DAX_SUBMIT_ERR_NOMAP		9
+#define	DAX_SUBMIT_ERR_NOACCESS		10
+#define	DAX_SUBMIT_ERR_TOOMANY		11
+#define	DAX_SUBMIT_ERR_UNAVAIL		12
+#define	DAX_SUBMIT_ERR_INTERNAL		13
+
+/* CCB_INFO states - must match HV_CCB_STATE_* definitions */
+#define	DAX_CCB_COMPLETED	0
+#define	DAX_CCB_ENQUEUED	1
+#define	DAX_CCB_INPROGRESS	2
+#define	DAX_CCB_NOTFOUND	3
+
+/* CCB_KILL actions - must match HV_CCB_KILL_* definitions */
+#define	DAX_KILL_COMPLETED	0
+#define	DAX_KILL_DEQUEUED	1
+#define	DAX_KILL_KILLED		2
+#define	DAX_KILL_NOTFOUND	3
+
+#endif /* _ORADAX_H */
diff --git a/drivers/sbus/char/Kconfig b/drivers/sbus/char/Kconfig
index 5ba684f..a785aa7 100644
--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -70,5 +70,13 @@ config DISPLAY7SEG
 	  another UltraSPARC-IIi-cEngine boardset with a 7-segment display,
 	  you should say N to this option.
 
+config ORACLE_DAX
+	tristate "Oracle Data Analytics Accelerator"
+	default m if SPARC64
+	help
+	 Driver for Oracle Data Analytics Accelerator, which is
+	 a coprocessor that performs database operations in hardware.
+	 It is available on M7 and M8 based systems only.
+
 endmenu
 
diff --git a/drivers/sbus/char/Makefile b/drivers/sbus/char/Makefile
index 78b6183..cdb5565 100644
--- a/drivers/sbus/char/Makefile
+++ b/drivers/sbus/char/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_SUN_OPENPROMIO)		+= openprom.o
 obj-$(CONFIG_TADPOLE_TS102_UCTRL)	+= uctrl.o
 obj-$(CONFIG_SUN_JSFLASH)		+= jsflash.o
 obj-$(CONFIG_BBC_I2C)			+= bbc.o
+obj-$(CONFIG_ORACLE_DAX) 		+= oradax.o
diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
new file mode 100644
index 0000000..d8597d5
--- /dev/null
+++ b/drivers/sbus/char/oradax.c
@@ -0,0 +1,1005 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Oracle Data Analytics Accelerator (DAX)
+ *
+ * DAX is a coprocessor which resides on the SPARC M7 (DAX1) and M8
+ * (DAX2) processor chips, and has direct access to the CPU's L3
+ * caches as well as physical memory. It can perform several
+ * operations on data streams with various input and output formats.
+ * The driver provides a transport mechanism only and has limited
+ * knowledge of the various opcodes and data formats. A user space
+ * library provides high level services and translates these into low
+ * level commands which are then passed into the driver and
+ * subsequently the hypervisor and the coprocessor.  The library is
+ * the recommended way for applications to use the coprocessor, and
+ * the driver interface is not intended for general use.
+ *
+ * See Documentation/sparc/oracle_dax.txt for more details.
+ */
+
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <asm/hypervisor.h>
+#include <asm/mdesc.h>
+#include <asm/oradax.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for Oracle Data Analytics Accelerator");
+
+#define	DAX_DBG_FLG_BASIC	0x01
+#define	DAX_DBG_FLG_STAT	0x02
+#define	DAX_DBG_FLG_INFO	0x04
+#define	DAX_DBG_FLG_ALL		0xff
+
+#define	dax_err(fmt, ...)      pr_err("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+#define	dax_info(fmt, ...)     pr_info("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+
+#define	dax_dbg(fmt, ...)	do {					\
+					if (dax_debug & DAX_DBG_FLG_BASIC)\
+						dax_info(fmt, ##__VA_ARGS__); \
+				} while (0)
+#define	dax_stat_dbg(fmt, ...)	do {					\
+					if (dax_debug & DAX_DBG_FLG_STAT) \
+						dax_info(fmt, ##__VA_ARGS__); \
+				} while (0)
+#define	dax_info_dbg(fmt, ...)	do { \
+					if (dax_debug & DAX_DBG_FLG_INFO) \
+						dax_info(fmt, ##__VA_ARGS__); \
+				} while (0)
+
+#define	DAX1_MINOR		1
+#define	DAX1_MAJOR		1
+#define	DAX2_MINOR		0
+#define	DAX2_MAJOR		2
+
+#define	DAX1_STR    "ORCL,sun4v-dax"
+#define	DAX2_STR    "ORCL,sun4v-dax2"
+
+#define	DAX_CA_ELEMS		(DAX_MMAP_LEN / sizeof(struct dax_cca))
+
+#define	DAX_CCB_USEC		100
+#define	DAX_CCB_RETRIES		10000
+
+/* stream types */
+enum {
+	OUT,
+	PRI,
+	SEC,
+	TBL,
+	NUM_STREAM_TYPES
+};
+
+/* completion status */
+#define	CCA_STAT_NOT_COMPLETED	0
+#define	CCA_STAT_COMPLETED	1
+#define	CCA_STAT_FAILED		2
+#define	CCA_STAT_KILLED		3
+#define	CCA_STAT_NOT_RUN	4
+#define	CCA_STAT_PIPE_OUT	5
+#define	CCA_STAT_PIPE_SRC	6
+#define	CCA_STAT_PIPE_DST	7
+
+/* completion err */
+#define	CCA_ERR_SUCCESS		0x0	/* no error */
+#define	CCA_ERR_OVERFLOW	0x1	/* buffer overflow */
+#define	CCA_ERR_DECODE		0x2	/* CCB decode error */
+#define	CCA_ERR_PAGE_OVERFLOW	0x3	/* page overflow */
+#define	CCA_ERR_KILLED		0x7	/* command was killed */
+#define	CCA_ERR_TIMEOUT		0x8	/* Timeout */
+#define	CCA_ERR_ADI		0x9	/* ADI error */
+#define	CCA_ERR_DATA_FMT	0xA	/* data format error */
+#define	CCA_ERR_OTHER_NO_RETRY	0xE	/* Other error, do not retry */
+#define	CCA_ERR_OTHER_RETRY	0xF	/* Other error, retry */
+#define	CCA_ERR_PARTIAL_SYMBOL	0x80	/* QP partial symbol warning */
+
+/* CCB address types */
+#define	DAX_ADDR_TYPE_NONE	0
+#define	DAX_ADDR_TYPE_VA_ALT	1	/* secondary context */
+#define	DAX_ADDR_TYPE_RA	2	/* real address */
+#define	DAX_ADDR_TYPE_VA	3	/* virtual address */
+
+/* dax_header_t opcode */
+#define	DAX_OP_SYNC_NOP		0x0
+#define	DAX_OP_EXTRACT		0x1
+#define	DAX_OP_SCAN_VALUE	0x2
+#define	DAX_OP_SCAN_RANGE	0x3
+#define	DAX_OP_TRANSLATE	0x4
+#define	DAX_OP_SELECT		0x5
+#define	DAX_OP_INVERT		0x10	/* OR with translate, scan opcodes */
+
+struct dax_header {
+	u32 ccb_version:4;	/* 31:28 CCB Version */
+				/* 27:24 Sync Flags */
+	u32 pipe:1;		/* Pipeline */
+	u32 longccb:1;		/* Longccb. Set for scan with lu2, lu3, lu4. */
+	u32 cond:1;		/* Conditional */
+	u32 serial:1;		/* Serial */
+	u32 opcode:8;		/* 23:16 Opcode */
+				/* 15:0 Address Type. */
+	u32 reserved:3;		/* 15:13 reserved */
+	u32 table_addr_type:2;	/* 12:11 Huffman Table Address Type */
+	u32 out_addr_type:3;	/* 10:8 Destination Address Type */
+	u32 sec_addr_type:3;	/* 7:5 Secondary Source Address Type */
+	u32 pri_addr_type:3;	/* 4:2 Primary Source Address Type */
+	u32 cca_addr_type:2;	/* 1:0 Completion Address Type */
+};
+
+struct dax_control {
+	u32 pri_fmt:4;		/* 31:28 Primary Input Format */
+	u32 pri_elem_size:5;	/* 27:23 Primary Input Element Size(less1) */
+	u32 pri_offset:3;	/* 22:20 Primary Input Starting Offset */
+	u32 sec_encoding:1;	/* 19    Secondary Input Encoding */
+				/*	 (must be 0 for Select) */
+	u32 sec_offset:3;	/* 18:16 Secondary Input Starting Offset */
+	u32 sec_elem_size:2;	/* 15:14 Secondary Input Element Size */
+				/*	 (must be 0 for Select) */
+	u32 out_fmt:2;		/* 13:12 Output Format */
+	u32 out_elem_size:2;	/* 11:10 Output Element Size */
+	u32 misc:10;		/* 9:0 Opcode specific info */
+};
+
+struct dax_data_access {
+	u64 flow_ctrl:2;	/* 63:62 Flow Control Type */
+	u64 pipe_target:2;	/* 61:60 Pipeline Target */
+	u64 out_buf_size:20;	/* 59:40 Output Buffer Size */
+				/*	 (cachelines less 1) */
+	u64 unused1:8;		/* 39:32 Reserved, Set to 0 */
+	u64 out_alloc:5;	/* 31:27 Output Allocation */
+	u64 unused2:1;		/* 26	 Reserved */
+	u64 pri_len_fmt:2;	/* 25:24 Input Length Format */
+	u64 pri_len:24;		/* 23:0  Input Element/Byte/Bit Count */
+				/*	 (less 1) */
+};
+
+struct dax_ccb {
+	struct dax_header hdr;	/* CCB Header */
+	struct dax_control ctrl;/* Control Word */
+	void *ca;		/* Completion Address */
+	void *pri;		/* Primary Input Address */
+	struct dax_data_access dac; /* Data Access Control */
+	void *sec;		/* Secondary Input Address */
+	u64 dword5;		/* depends on opcode */
+	void *out;		/* Output Address */
+	void *tbl;		/* Table Address or bitmap */
+};
+
+struct dax_cca {
+	u8	status;		/* user may mwait on this address */
+	u8	err;		/* user visible error notification */
+	u8	rsvd[2];	/* reserved */
+	u32	n_remaining;	/* for QP partial symbol warning */
+	u32	output_sz;	/* output in bytes */
+	u32	rsvd2;		/* reserved */
+	u64	run_cycles;	/* run time in OCND2 cycles */
+	u64	run_stats;	/* nothing reported in version 1.0 */
+	u32	n_processed;	/* number input elements */
+	u32	rsvd3[5];	/* reserved */
+	u64	retval;		/* command return value */
+	u64	rsvd4[8];	/* reserved */
+};
+
+/* per thread CCB context */
+struct dax_ctx {
+	struct dax_ccb		*ccb_buf;
+	u64			ccb_buf_ra;	/* cached RA of ccb_buf  */
+	struct dax_cca		*ca_buf;
+	u64			ca_buf_ra;	/* cached RA of ca_buf   */
+	struct page		*pages[DAX_CA_ELEMS][NUM_STREAM_TYPES];
+						/* array of locked pages */
+	struct task_struct	*owner;		/* thread that owns ctx  */
+	struct task_struct	*client;	/* requesting thread     */
+	union ccb_result	result;
+	u32			ccb_count;
+	u32			fail_count;
+};
+
+/* driver public entry points */
+static int dax_open(struct inode *inode, struct file *file);
+static ssize_t dax_read(struct file *filp, char __user *buf,
+			size_t count, loff_t *ppos);
+static ssize_t dax_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *ppos);
+static int dax_devmap(struct file *f, struct vm_area_struct *vma);
+static int dax_close(struct inode *i, struct file *f);
+
+static const struct file_operations dax_fops = {
+	.owner	=	THIS_MODULE,
+	.open	=	dax_open,
+	.read	=	dax_read,
+	.write	=	dax_write,
+	.mmap	=	dax_devmap,
+	.release =	dax_close,
+};
+
+static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
+			size_t count, loff_t *ppos);
+static int dax_ccb_info(u64 ca, struct ccb_info_result *info);
+static int dax_ccb_kill(u64 ca, u16 *kill_res);
+
+static struct cdev c_dev;
+static struct class *cl;
+static dev_t first;
+
+static int max_ccb_version;
+static int dax_debug;
+module_param(dax_debug, int, 0644);
+MODULE_PARM_DESC(dax_debug, "Debug flags");
+
+static int __init dax_attach(void)
+{
+	unsigned long dummy, hv_rv, major, minor, minor_requested, max_ccbs;
+	struct mdesc_handle *hp = mdesc_grab();
+	char *prop, *dax_name;
+	bool found = false;
+	int len, ret = 0;
+	u64 pn;
+
+	if (hp = NULL) {
+		dax_err("Unable to grab mdesc");
+		return -ENODEV;
+	}
+
+	mdesc_for_each_node_by_name(hp, pn, "virtual-device") {
+		prop = (char *)mdesc_get_property(hp, pn, "name", &len);
+		if (prop = NULL)
+			continue;
+		if (strncmp(prop, "dax", strlen("dax")))
+			continue;
+		dax_dbg("Found node 0x%llx = %s", pn, prop);
+
+		prop = (char *)mdesc_get_property(hp, pn, "compatible", &len);
+		if (prop = NULL)
+			continue;
+		dax_dbg("Found node 0x%llx = %s", pn, prop);
+		found = true;
+		break;
+	}
+
+	if (!found) {
+		dax_err("No DAX device found");
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (strncmp(prop, DAX2_STR, strlen(DAX2_STR)) = 0) {
+		dax_name = DAX_NAME "2";
+		major = DAX2_MAJOR;
+		minor_requested = DAX2_MINOR;
+		max_ccb_version = 1;
+		dax_dbg("MD indicates DAX2 coprocessor");
+	} else if (strncmp(prop, DAX1_STR, strlen(DAX1_STR)) = 0) {
+		dax_name = DAX_NAME "1";
+		major = DAX1_MAJOR;
+		minor_requested = DAX1_MINOR;
+		max_ccb_version = 0;
+		dax_dbg("MD indicates DAX1 coprocessor");
+	} else {
+		dax_err("Unknown dax type: %s", prop);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	minor = minor_requested;
+	dax_dbg("Registering DAX HV api with major %ld minor %ld", major,
+		minor);
+	if (sun4v_hvapi_register(HV_GRP_DAX, major, &minor)) {
+		dax_err("hvapi_register failed");
+		ret = -ENODEV;
+		goto done;
+	} else {
+		dax_dbg("Max minor supported by HV = %ld (major %ld)", minor,
+			major);
+		minor = min(minor, minor_requested);
+		dax_dbg("registered DAX major %ld minor %ld", major, minor);
+	}
+
+	/* submit a zero length ccb array to query coprocessor queue size */
+	hv_rv = sun4v_ccb_submit(0, 0, HV_CCB_QUERY_CMD, 0, &max_ccbs, &dummy);
+	if (hv_rv != 0) {
+		dax_err("get_hwqueue_size failed with status=%ld and max_ccbs=%ld",
+			hv_rv, max_ccbs);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (max_ccbs != DAX_MAX_CCBS) {
+		dax_err("HV reports unsupported max_ccbs=%ld", max_ccbs);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (alloc_chrdev_region(&first, 0, 1, DAX_NAME) < 0) {
+		dax_err("alloc_chrdev_region failed");
+		ret = -ENXIO;
+		goto done;
+	}
+
+	cl = class_create(THIS_MODULE, DAX_NAME);
+	if (cl = NULL) {
+		dax_err("class_create failed");
+		ret = -ENXIO;
+		goto class_error;
+	}
+
+	if (device_create(cl, NULL, first, NULL, dax_name) = NULL) {
+		dax_err("device_create failed");
+		ret = -ENXIO;
+		goto device_error;
+	}
+
+	cdev_init(&c_dev, &dax_fops);
+	if (cdev_add(&c_dev, first, 1) = -1) {
+		dax_err("cdev_add failed");
+		ret = -ENXIO;
+		goto cdev_error;
+	}
+
+	pr_info("Attached DAX module\n");
+	goto done;
+
+cdev_error:
+	device_destroy(cl, first);
+device_error:
+	class_destroy(cl);
+class_error:
+	unregister_chrdev_region(first, 1);
+done:
+	mdesc_release(hp);
+	return ret;
+}
+module_init(dax_attach);
+
+static void __exit dax_detach(void)
+{
+	pr_info("Cleaning up DAX module\n");
+	cdev_del(&c_dev);
+	device_destroy(cl, first);
+	class_destroy(cl);
+	unregister_chrdev_region(first, 1);
+}
+module_exit(dax_detach);
+
+/* map completion area */
+static int dax_devmap(struct file *f, struct vm_area_struct *vma)
+{
+	struct dax_ctx *ctx = (struct dax_ctx *)f->private_data;
+	size_t len = vma->vm_end - vma->vm_start;
+
+	dax_dbg("len=0x%lx, flags=0x%lx", len, vma->vm_flags);
+
+	if (ctx->owner != current) {
+		dax_dbg("devmap called from wrong thread");
+		return -EINVAL;
+	}
+
+	if (len != DAX_MMAP_LEN) {
+		dax_dbg("len(%lu) != DAX_MMAP_LEN(%d)", len, DAX_MMAP_LEN);
+		return -EINVAL;
+	}
+
+	/* completion area is mapped read-only for user */
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	if (remap_pfn_range(vma, vma->vm_start, ctx->ca_buf_ra >> PAGE_SHIFT,
+			    len, vma->vm_page_prot))
+		return -EAGAIN;
+
+	dax_dbg("mmapped completion area at uva 0x%lx", vma->vm_start);
+	return 0;
+}
+
+/* Unlock user pages. Called during dequeue or device close */
+static void dax_unlock_pages(struct dax_ctx *ctx, int ccb_index, int nelem)
+{
+	int i, j;
+
+	for (i = ccb_index; i < ccb_index + nelem; i++) {
+		for (j = 0; j < NUM_STREAM_TYPES; j++) {
+			struct page *p = ctx->pages[i][j];
+
+			if (p) {
+				dax_dbg("freeing page %p", p);
+				if (j = OUT)
+					set_page_dirty(p);
+				put_page(p);
+				ctx->pages[i][j] = NULL;
+			}
+		}
+	}
+}
+
+static int dax_lock_page(void *va, struct page **p)
+{
+	int ret;
+
+	dax_dbg("uva %p", va);
+
+	ret = get_user_pages_fast((unsigned long)va, 1, 1, p);
+	if (ret = 1) {
+		dax_dbg("locked page %p, for VA %p", *p, va);
+		return 0;
+	}
+
+	dax_dbg("get_user_pages failed, va=%p, ret=%d", va, ret);
+	return -1;
+}
+
+static int dax_lock_pages(struct dax_ctx *ctx, int idx,
+			  int nelem, u64 *err_va)
+{
+	int i;
+
+	for (i = 0; i < nelem; i++) {
+		struct dax_ccb *ccbp = &ctx->ccb_buf[i];
+
+		/*
+		 * For each address in the CCB whose type is virtual,
+		 * lock the page and change the type to virtual alternate
+		 * context. On error, return the offending address in
+		 * err_va.
+		 */
+		if (ccbp->hdr.out_addr_type = DAX_ADDR_TYPE_VA) {
+			dax_dbg("output");
+			if (dax_lock_page(ccbp->out,
+					  &ctx->pages[i + idx][OUT]) != 0) {
+				*err_va = (u64)ccbp->out;
+				goto error;
+			}
+			ccbp->hdr.out_addr_type = DAX_ADDR_TYPE_VA_ALT;
+		}
+
+		if (ccbp->hdr.pri_addr_type = DAX_ADDR_TYPE_VA) {
+			dax_dbg("input");
+			if (dax_lock_page(ccbp->pri,
+					  &ctx->pages[i + idx][PRI]) != 0) {
+				*err_va = (u64)ccbp->pri;
+				goto error;
+			}
+			ccbp->hdr.pri_addr_type = DAX_ADDR_TYPE_VA_ALT;
+		}
+
+		if (ccbp->hdr.sec_addr_type = DAX_ADDR_TYPE_VA) {
+			dax_dbg("sec input");
+			if (dax_lock_page(ccbp->sec,
+					  &ctx->pages[i + idx][SEC]) != 0) {
+				*err_va = (u64)ccbp->sec;
+				goto error;
+			}
+			ccbp->hdr.sec_addr_type = DAX_ADDR_TYPE_VA_ALT;
+		}
+
+		if (ccbp->hdr.table_addr_type = DAX_ADDR_TYPE_VA) {
+			dax_dbg("tbl");
+			if (dax_lock_page(ccbp->tbl,
+					  &ctx->pages[i + idx][TBL]) != 0) {
+				*err_va = (u64)ccbp->tbl;
+				goto error;
+			}
+			ccbp->hdr.table_addr_type = DAX_ADDR_TYPE_VA_ALT;
+		}
+
+		/* skip over 2nd 64 bytes of long CCB */
+		if (ccbp->hdr.longccb)
+			i++;
+	}
+	return DAX_SUBMIT_OK;
+
+error:
+	dax_unlock_pages(ctx, idx, nelem);
+	return DAX_SUBMIT_ERR_NOACCESS;
+}
+
+static void dax_ccb_wait(struct dax_ctx *ctx, int idx)
+{
+	int ret, nretries;
+	u16 kill_res;
+
+	dax_dbg("idx=%d", idx);
+
+	for (nretries = 0; nretries < DAX_CCB_RETRIES; nretries++) {
+		if (ctx->ca_buf[idx].status = CCA_STAT_NOT_COMPLETED)
+			udelay(DAX_CCB_USEC);
+		else
+			return;
+	}
+	dax_dbg("ctx (%p): CCB[%d] timed out, wait usec=%d, retries=%d. Killing ccb",
+		(void *)ctx, idx, DAX_CCB_USEC, DAX_CCB_RETRIES);
+
+	ret = dax_ccb_kill(ctx->ca_buf_ra + idx * sizeof(struct dax_cca),
+			   &kill_res);
+	dax_dbg("Kill CCB[%d] %s", idx, ret ? "failed" : "succeeded");
+}
+
+static int dax_close(struct inode *ino, struct file *f)
+{
+	struct dax_ctx *ctx = (struct dax_ctx *)f->private_data;
+	int i;
+
+	f->private_data = NULL;
+
+	for (i = 0; i < DAX_CA_ELEMS; i++) {
+		if (ctx->ca_buf[i].status = CCA_STAT_NOT_COMPLETED) {
+			dax_dbg("CCB[%d] not completed", i);
+			dax_ccb_wait(ctx, i);
+		}
+		dax_unlock_pages(ctx, i, 1);
+	}
+
+	kfree(ctx->ccb_buf);
+	kfree(ctx->ca_buf);
+	dax_stat_dbg("CCBs: %d good, %d bad", ctx->ccb_count, ctx->fail_count);
+	kfree(ctx);
+
+	return 0;
+}
+
+static ssize_t dax_read(struct file *f, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct dax_ctx *ctx = f->private_data;
+
+	if (ctx->client != current)
+		return -EUSERS;
+
+	ctx->client = NULL;
+
+	if (count != sizeof(union ccb_result))
+		return -EINVAL;
+	if (copy_to_user(buf, &ctx->result, sizeof(union ccb_result)))
+		return -EFAULT;
+	return count;
+}
+
+static ssize_t dax_write(struct file *f, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct dax_ctx *ctx = f->private_data;
+	struct dax_command hdr;
+	unsigned long ca;
+	int i, idx, ret;
+
+	if (ctx->client != NULL)
+		return -EINVAL;
+
+	if (count = 0 || count > DAX_MAX_CCBS * sizeof(struct dax_ccb))
+		return -EINVAL;
+
+	if (count % sizeof(struct dax_ccb) = 0)
+		return dax_ccb_exec(ctx, buf, count, ppos); /* CCB EXEC */
+
+	if (count != sizeof(struct dax_command))
+		return -EINVAL;
+
+	/* immediate command */
+	if (ctx->owner != current)
+		return -EUSERS;
+
+	if (copy_from_user(&hdr, buf, sizeof(hdr)))
+		return -EFAULT;
+
+	ca = ctx->ca_buf_ra + hdr.ca_offset;
+
+	switch (hdr.command) {
+	case CCB_KILL:
+		if (hdr.ca_offset >= DAX_MMAP_LEN) {
+			dax_dbg("invalid ca_offset (%d) >= ca_buflen (%d)",
+				hdr.ca_offset, DAX_MMAP_LEN);
+			return -EINVAL;
+		}
+
+		ret = dax_ccb_kill(ca, &ctx->result.kill.action);
+		if (ret != 0) {
+			dax_dbg("dax_ccb_kill failed (ret=%d)", ret);
+			return ret;
+		}
+
+		dax_info_dbg("killed (ca_offset %d)", hdr.ca_offset);
+		idx = hdr.ca_offset / sizeof(struct dax_cca);
+		ctx->ca_buf[idx].status = CCA_STAT_KILLED;
+		ctx->ca_buf[idx].err = CCA_ERR_KILLED;
+		ctx->client = current;
+		return count;
+
+	case CCB_INFO:
+		if (hdr.ca_offset >= DAX_MMAP_LEN) {
+			dax_dbg("invalid ca_offset (%d) >= ca_buflen (%d)",
+				hdr.ca_offset, DAX_MMAP_LEN);
+			return -EINVAL;
+		}
+
+		ret = dax_ccb_info(ca, &ctx->result.info);
+		if (ret != 0) {
+			dax_dbg("dax_ccb_info failed (ret=%d)", ret);
+			return ret;
+		}
+
+		dax_info_dbg("info succeeded on ca_offset %d", hdr.ca_offset);
+		ctx->client = current;
+		return count;
+
+	case CCB_DEQUEUE:
+		for (i = 0; i < DAX_CA_ELEMS; i++) {
+			if (ctx->ca_buf[i].status !+			    CCA_STAT_NOT_COMPLETED)
+				dax_unlock_pages(ctx, i, 1);
+		}
+		return count;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int dax_open(struct inode *inode, struct file *f)
+{
+	struct dax_ctx *ctx = NULL;
+	int i;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (ctx = NULL)
+		goto done;
+
+	ctx->ccb_buf = kcalloc(DAX_MAX_CCBS, sizeof(struct dax_ccb),
+			       GFP_KERNEL);
+	if (ctx->ccb_buf = NULL)
+		goto done;
+
+	ctx->ccb_buf_ra = virt_to_phys(ctx->ccb_buf);
+	dax_dbg("ctx->ccb_buf=0x%p, ccb_buf_ra=0x%llx",
+		(void *)ctx->ccb_buf, ctx->ccb_buf_ra);
+
+	/* allocate CCB completion area buffer */
+	ctx->ca_buf = kzalloc(DAX_MMAP_LEN, GFP_KERNEL);
+	if (ctx->ca_buf = NULL)
+		goto alloc_error;
+	for (i = 0; i < DAX_CA_ELEMS; i++)
+		ctx->ca_buf[i].status = CCA_STAT_COMPLETED;
+
+	ctx->ca_buf_ra = virt_to_phys(ctx->ca_buf);
+	dax_dbg("ctx=0x%p, ctx->ca_buf=0x%p, ca_buf_ra=0x%llx",
+		(void *)ctx, (void *)ctx->ca_buf, ctx->ca_buf_ra);
+
+	ctx->owner = current;
+	f->private_data = ctx;
+	return 0;
+
+alloc_error:
+	kfree(ctx->ccb_buf);
+done:
+	if (ctx != NULL)
+		kfree(ctx);
+	return -ENOMEM;
+}
+
+static char *dax_hv_errno(unsigned long hv_ret, int *ret)
+{
+	switch (hv_ret) {
+	case HV_EBADALIGN:
+		*ret = -EFAULT;
+		return "HV_EBADALIGN";
+	case HV_ENORADDR:
+		*ret = -EFAULT;
+		return "HV_ENORADDR";
+	case HV_EINVAL:
+		*ret = -EINVAL;
+		return "HV_EINVAL";
+	case HV_EWOULDBLOCK:
+		*ret = -EAGAIN;
+		return "HV_EWOULDBLOCK";
+	case HV_ENOACCESS:
+		*ret = -EPERM;
+		return "HV_ENOACCESS";
+	default:
+		break;
+	}
+
+	*ret = -EIO;
+	return "UNKNOWN";
+}
+
+static int dax_ccb_kill(u64 ca, u16 *kill_res)
+{
+	unsigned long hv_ret;
+	int count, ret = 0;
+	char *err_str;
+
+	for (count = 0; count < DAX_CCB_RETRIES; count++) {
+		dax_dbg("attempting kill on ca_ra 0x%llx", ca);
+		hv_ret = sun4v_ccb_kill(ca, kill_res);
+
+		if (hv_ret = HV_EOK) {
+			dax_info_dbg("HV_EOK (ca_ra 0x%llx): %d", ca,
+				     *kill_res);
+		} else {
+			err_str = dax_hv_errno(hv_ret, &ret);
+			dax_dbg("%s (ca_ra 0x%llx)", err_str, ca);
+		}
+
+		if (ret != -EAGAIN)
+			return ret;
+		dax_info_dbg("ccb_kill count = %d", count);
+		udelay(DAX_CCB_USEC);
+	}
+
+	return -EAGAIN;
+}
+
+static int dax_ccb_info(u64 ca, struct ccb_info_result *info)
+{
+	unsigned long hv_ret;
+	char *err_str;
+	int ret = 0;
+
+	dax_dbg("attempting info on ca_ra 0x%llx", ca);
+	hv_ret = sun4v_ccb_info(ca, info);
+
+	if (hv_ret = HV_EOK) {
+		dax_info_dbg("HV_EOK (ca_ra 0x%llx): %d", ca, info->state);
+		if (info->state = DAX_CCB_ENQUEUED) {
+			dax_info_dbg("dax_unit %d, queue_num %d, queue_pos %d",
+				     info->inst_num, info->q_num, info->q_pos);
+		}
+	} else {
+		err_str = dax_hv_errno(hv_ret, &ret);
+		dax_dbg("%s (ca_ra 0x%llx)", err_str, ca);
+	}
+
+	return ret;
+}
+
+static void dax_prt_ccbs(struct dax_ccb *ccb, int nelem)
+{
+	int i, j;
+	u64 *ccbp;
+
+	dax_dbg("ccb buffer:");
+	for (i = 0; i < nelem; i++) {
+		ccbp = (u64 *)&ccb[i];
+		dax_dbg(" %sccb[%d]", ccb[i].hdr.longccb ? "long " : "",  i);
+		for (j = 0; j < 8; j++)
+			dax_dbg("\tccb[%d].dwords[%d]=0x%llx",
+				i, j, *(ccbp + j));
+	}
+}
+
+/*
+ * Validates user CCB content.  Also sets completion address and address types
+ * for all addresses contained in CCB.
+ */
+static int dax_preprocess_usr_ccbs(struct dax_ctx *ctx, int idx, int nelem)
+{
+	int i;
+
+	/*
+	 * The user is not allowed to specify real address types in
+	 * the CCB header.  This must be enforced by the kernel before
+	 * submitting the CCBs to HV.  The only allowed values for all
+	 * address fields are VA or IMM
+	 */
+	for (i = 0; i < nelem; i++) {
+		struct dax_ccb *ccbp = &ctx->ccb_buf[i];
+		unsigned long ca_offset;
+
+		if (ccbp->hdr.ccb_version > max_ccb_version)
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+
+		switch (ccbp->hdr.opcode) {
+		case DAX_OP_SYNC_NOP:
+		case DAX_OP_EXTRACT:
+		case DAX_OP_SCAN_VALUE:
+		case DAX_OP_SCAN_RANGE:
+		case DAX_OP_TRANSLATE:
+		case DAX_OP_SCAN_VALUE | DAX_OP_INVERT:
+		case DAX_OP_SCAN_RANGE | DAX_OP_INVERT:
+		case DAX_OP_TRANSLATE | DAX_OP_INVERT:
+		case DAX_OP_SELECT:
+			break;
+		default:
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		if (ccbp->hdr.out_addr_type != DAX_ADDR_TYPE_VA &&
+		    ccbp->hdr.out_addr_type != DAX_ADDR_TYPE_NONE) {
+			dax_dbg("invalid out_addr_type in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		if (ccbp->hdr.pri_addr_type != DAX_ADDR_TYPE_VA &&
+		    ccbp->hdr.pri_addr_type != DAX_ADDR_TYPE_NONE) {
+			dax_dbg("invalid pri_addr_type in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		if (ccbp->hdr.sec_addr_type != DAX_ADDR_TYPE_VA &&
+		    ccbp->hdr.sec_addr_type != DAX_ADDR_TYPE_NONE) {
+			dax_dbg("invalid sec_addr_type in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		if (ccbp->hdr.table_addr_type != DAX_ADDR_TYPE_VA &&
+		    ccbp->hdr.table_addr_type != DAX_ADDR_TYPE_NONE) {
+			dax_dbg("invalid table_addr_type in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		/* set completion (real) address and address type */
+		ccbp->hdr.cca_addr_type = DAX_ADDR_TYPE_RA;
+		ca_offset = (idx + i) * sizeof(struct dax_cca);
+		ccbp->ca = (void *)ctx->ca_buf_ra + ca_offset;
+		memset(&ctx->ca_buf[idx + i], 0, sizeof(struct dax_cca));
+
+		dax_dbg("ccb[%d]=%p, ca_offset=0x%lx, compl RA=0x%llx",
+			i, ccbp, ca_offset, ctx->ca_buf_ra + ca_offset);
+
+		/* skip over 2nd 64 bytes of long CCB */
+		if (ccbp->hdr.longccb)
+			i++;
+	}
+
+	return DAX_SUBMIT_OK;
+}
+
+static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	unsigned long accepted_len, hv_rv;
+	int i, idx, nccbs, naccepted;
+
+	ctx->client = current;
+	idx = *ppos;
+	nccbs = count / sizeof(struct dax_ccb);
+
+	if (ctx->owner != current) {
+		dax_dbg("wrong thread");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_THR_INIT;
+		return 0;
+	}
+	dax_dbg("args: ccb_buf_len=%ld, idx=%d", count, idx);
+
+	/* for given index and length, verify ca_buf range exists */
+	if (idx + nccbs >= DAX_CA_ELEMS) {
+		ctx->result.exec.status = DAX_SUBMIT_ERR_NO_CA_AVAIL;
+		return 0;
+	}
+
+	/*
+	 * Copy CCBs into kernel buffer to prevent modification by the
+	 * user in between validation and submission.
+	 */
+	if (copy_from_user(ctx->ccb_buf, buf, count)) {
+		dax_dbg("copyin of user CCB buffer failed");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_CCB_ARR_MMU_MISS;
+		return 0;
+	}
+
+	/* check to see if ca_buf[idx] .. ca_buf[idx + nccbs] are available */
+	for (i = idx; i < idx + nccbs; i++) {
+		if (ctx->ca_buf[i].status = CCA_STAT_NOT_COMPLETED) {
+			dax_dbg("CA range not available, dequeue needed");
+			ctx->result.exec.status = DAX_SUBMIT_ERR_NO_CA_AVAIL;
+			return 0;
+		}
+	}
+	dax_unlock_pages(ctx, idx, nccbs);
+
+	ctx->result.exec.status = dax_preprocess_usr_ccbs(ctx, idx, nccbs);
+	if (ctx->result.exec.status != DAX_SUBMIT_OK)
+		return 0;
+
+	ctx->result.exec.status = dax_lock_pages(ctx, idx, nccbs,
+						 &ctx->result.exec.status_data);
+	if (ctx->result.exec.status != DAX_SUBMIT_OK)
+		return 0;
+
+	if (dax_debug & DAX_DBG_FLG_BASIC)
+		dax_prt_ccbs(ctx->ccb_buf, nccbs);
+
+	hv_rv = sun4v_ccb_submit(ctx->ccb_buf_ra, count,
+				 HV_CCB_QUERY_CMD | HV_CCB_VA_SECONDARY, 0,
+				 &accepted_len, &ctx->result.exec.status_data);
+
+	switch (hv_rv) {
+	case HV_EOK:
+		/*
+		 * Hcall succeeded with no errors but the accepted
+		 * length may be less than the requested length.  The
+		 * only way the driver can resubmit the remainder is
+		 * to wait for completion of the submitted CCBs since
+		 * there is no way to guarantee the ordering semantics
+		 * required by the client applications.  Therefore we
+		 * let the user library deal with resubmissions.
+		 */
+		ctx->result.exec.status = DAX_SUBMIT_OK;
+		break;
+	case HV_EWOULDBLOCK:
+		/*
+		 * This is a transient HV API error. The user library
+		 * can retry.
+		 */
+		dax_dbg("hcall returned HV_EWOULDBLOCK");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_WOULDBLOCK;
+		break;
+	case HV_ENOMAP:
+		/*
+		 * HV was unable to translate a VA. The VA it could
+		 * not translate is returned in the status_data param.
+		 */
+		dax_dbg("hcall returned HV_ENOMAP");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_NOMAP;
+		break;
+	case HV_EINVAL:
+		/*
+		 * This is the result of an invalid user CCB as HV is
+		 * validating some of the user CCB fields.  Pass this
+		 * error back to the user. There is no supporting info
+		 * to isolate the invalid field.
+		 */
+		dax_dbg("hcall returned HV_EINVAL");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_CCB_INVAL;
+		break;
+	case HV_ENOACCESS:
+		/*
+		 * HV found a VA that did not have the appropriate
+		 * permissions (such as the w bit). The VA in question
+		 * is returned in status_data param.
+		 */
+		dax_dbg("hcall returned HV_ENOACCESS");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_NOACCESS;
+		break;
+	case HV_EUNAVAILABLE:
+		/*
+		 * The requested CCB operation could not be performed
+		 * at this time. Return the specific unavailable code
+		 * in the status_data field.
+		 */
+		dax_dbg("hcall returned HV_EUNAVAILABLE");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_UNAVAIL;
+		break;
+	default:
+		ctx->result.exec.status = DAX_SUBMIT_ERR_INTERNAL;
+		dax_dbg("unknown hcall return value (%ld)", hv_rv);
+		break;
+	}
+
+	/* unlock pages associated with the unaccepted CCBs */
+	naccepted = accepted_len / sizeof(struct dax_ccb);
+	dax_unlock_pages(ctx, idx + naccepted, nccbs - naccepted);
+
+	/* mark unaccepted CCBs as not completed */
+	for (i = idx + naccepted; i < idx + nccbs; i++)
+		ctx->ca_buf[i].status = CCA_STAT_COMPLETED;
+
+	ctx->ccb_count += naccepted;
+	ctx->fail_count += nccbs - naccepted;
+
+	dax_dbg("hcall rv=%ld, accepted_len=%ld, status_data=0x%llx, ret status=%d",
+		hv_rv, accepted_len, ctx->result.exec.status_data,
+		ctx->result.exec.status);
+
+	if (count = accepted_len)
+		ctx->client = NULL; /* no read needed to complete protocol */
+	return accepted_len;
+}
-- 
1.7.1

